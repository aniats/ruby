require 'roda'
require 'yaml'
require 'json'

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect '/hello'
    end

    r.on 'hello' do
      r.get do
        'Hey, there'
      end
    end

    r.on 'cool' do
      r.get 'hello', String, String do |name, surname|
        "Hey, #{name} #{surname}!"
      end
    end

    r.on 'calc' do
      r.get 'min', String, String do |num1, num2|
        num1 = num1.to_i
        num2 = num2.to_i
        res = [num1, num2].min
        "Min num is: #{res}"
      end

      r.get 'multiply', String, String do |num1, num2|
        num1 = num1.to_f
        num2 = num2.to_f
        "#{num1} * #{num2} = #{num1 * num2}"
      end
    end

    r.on 'get' do
      r.on 'sophisticated' do
        r.get 'rng' do
          num1 = r.params['min'].to_i
          num2 = r.params['max'].to_i

          if r.params['min'].nil? || r.params['max'].nil?
            'Incorrect expression, check your arguments again'
          else
            "Random number in range #{num1}..#{num2}: #{rand num1..num2}"
          end
        end
      end
    end

    r.on 'worker' do
      r.get 'ID' do
        if r.params['id'].nil?
          'Incorrect id, check once again'
        else
          id = r.params['id'].to_i
          success = false

          res = OpenStruct.new
          hash = YAML.load_file('worker.yml')
          hash['people'].each_with_index do |value, index|
            next unless index == id

            success = true
            res.status = 'success'
            res.data = value
            res = res.to_json
          end

          unless success
            res.status = 'error'
            res.message = 'does not exist'
            res = res.to_json
          end

          JSON.parse(res)
        end
      end
    end

    r.on 'rng' do
      num = rand 100..5000
      "Random num in range 100..5000: #{num}"
    end

    # r.on "a" do           # /a branch
    #   r.on "b" do         # /a/b branch
    #     r.is "c" do       # /a/b/c request
    #       r.get do
    #         "Request from a/b/c"
    #       end    # GET  /a/b/c request
    #       r.post do end   # POST /a/b/c request
    #     end
    #     r.get "d" do
    #       "Request from 'd'"
    #     end  # GET  /a/b/d request
    #     r.post "e" do end # POST /a/b/e request
    #   end
    # end

    # GET /post/2011/02/16/hello
    # r.get "post", Integer, Integer, Integer, String do |year, month, day, slug|
    #   "#{year}-#{month}-#{day} #{slug}" #=> "2011-02-16 hello"
    # end
  end
end