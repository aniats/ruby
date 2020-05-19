# frozen_string_literal: true

require 'forme'
require 'roda'
require_relative 'models'

# The core class of the web application for managing your books
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:list] = TriangleList.new([
                                   Triangle.new(5, 12, 13),
                                   Triangle.new(8, 15, 17),
                                   Triangle.new(7, 24, 25),
                                   Triangle.new(5, 5, 5),
                                   Triangle.new(6, 6, 3),
                                   Triangle.new(3, 5, 6)
                                 ])

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      view('main')
    end

    r.on 'new_triangle' do
      r.get do
        @params = {}
        view('new_triangle')
      end

      r.post do
        @params = DryResultFormeAdapter.new(NewTriangleFormScheme.call(r.params))
        if @params.success?
          opts[:list].add_triangle(Triangle.new(@params[:first], @params[:second], @params[:third]))
          r.redirect '/triangle'
        else
          view('new_triangle')
        end
      end
    end

    r.on 'triangle' do
      r.is do
        @params = DryResultFormeAdapter.new(TriangleFilterFormSchema.call(r.params))
        @filtered_triangles = if @params.success?
                                opts[:list].filter(@params[:min], @params[:max])
                              else
                                opts[:list].triangles_by_area
                              end
        view('triangle')
      end
    end
  end
end
