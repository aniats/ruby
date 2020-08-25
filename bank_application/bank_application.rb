# frozen_string_literal: true

require_relative 'models'

require 'date'
require 'forme'
require 'roda'

# The application class
class BankApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render
  plugin :status_handler
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  require_relative 'routes/bank.rb'

  opts[:store] = Store.new
  opts[:contributor_list] = opts[:store].contributor_list
  opts[:deposit_list] = opts[:store].deposit_list

  status_handler(404) do
    view('bank/not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      r.redirect bank_path
    end
  end
end
