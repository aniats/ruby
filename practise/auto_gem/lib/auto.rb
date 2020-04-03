# frozen_string_literal: true
# Auto class
class Auto
    attr_reader :brand, :model, :manufacture_year, :gasoline_consumption

    def initialize(brand, model, manufacture_year , gasoline_consumption)
        @brand = brand
        @model = model
        @manufacture_year  = manufacture_year
        @gasoline_consumption = gasoline_consumption
    end

    def to_s
        'Brand : #{@brand} Model: #{@model} Manufacture year: #{@manufacture_year} Gasoline Consumption: #{@gasoline_consumption}'
    end

end