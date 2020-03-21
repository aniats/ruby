require 'json'
require_relative 'auto'
require_relative 'fleet'

puts "This program simulates car showroom."
puts "You can find out average gasoline consumption by brand, amount of models in showroom, amount of cars of some brand."

fleet = Fleet.new
fleet.load_from_file('cars-list.json')

#puts fleet.consumption_by_brand("BMW")
#puts fleet.number_by_model("A5 2,0i")
#puts fleet.number_by_brand("BMW")
#puts fleet.average_consumption
#fleet.to_s  