# frozen_string_literal: true

require_relative 'movie_list.rb'
require_relative 'movie.rb'

# RatingClass
class RatingCreator
  def check_file(file_name)
    puts "Error! A file #{file_name} not found!" unless File.exist?(file_name)
    exit unless File.exist?(file_name)
  end

  def check_empty(file_name)
    puts "A file #{file_name} is empty" if File.zero?(file_name)
    exit if File.zero?(file_name)
  end

  def check_arguments
    if ARGV.length == 2
      ARGV.each do |file_name|
        check_file(file_name)
      end
      check_empty(ARGV[0])
    else
      puts 'Please, specify data file.'
      exit
    end
  end

  def create
    check_arguments
    res = MovieList.new
    res.read_data(ARGV[0])
    res.print_all_movies
    res.save_sorted_list(ARGV[1])
  end
end
