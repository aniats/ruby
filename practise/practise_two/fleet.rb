class Fleet
    attr_reader :cars, :grades

    def initialize(cars = [])
        @cars = Array.new
    end

    def add(car)
        @cars << car
    end

    def load_from_file(file_name) 
        json_data = File.read(file_name)
        ruby_objects = JSON.parse(json_data)
        ruby_objects.map do |ruby_objects|
            element = Auto.new(ruby_objects['mark'], ruby_objects['model'], ruby_objects['year'], ruby_objects['consumption'])
            add(element)
        end
    end

    def average_consumption
        amount = @cars.length
        sum = 0.0
        @cars.map do |car|
            sum += car.gasoline_consumption
        end
        sum / amount
    end

    def consumption_by_brand(brand)
        amount = 0
        sum = 0.0
        @cars.map do |car|
            if car.brand == brand
                amount += 1
                sum += car.gasoline_consumption
            end
        end
        sum / amount
    end

    def number_by_model(model)
        amount = 0
        @cars.map do |car|
            if car.model == model
                amount += 1
            end
        end
        amount
    end

    def number_by_brand(brand)
        amount = 0
        @cars.map do |car|
            if car.brand == brand
                amount += 1
            end
        end
        amount
    end

    def to_s
        @cars.map do |car|
            puts car
        end
    end
end