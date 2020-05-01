# frozen_string_literal: true

require 'csv'

# MovieList Class
class MovieList
  attr_reader :movies

  def initialize
    @movies = []
  end

  def read_data(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @movies.push(Movie.new(row[0], row[1], row[2], row[3], row[4]))
    end
  end

  def print_all_movies
    @movies.each do |el|
      puts el.to_s
    end
  end

  def sort
    @movies.sort!
  end

  def save_sorted_list(file_path)
    @movies.sort
    CSV.open(file_path, 'wb') do |csv|
      csv << %w[title ogon_rating kinopoisk imdb metacritic rotten_tomatoes]
      @movies.each do |el|
        csv << [el.title, el.ogon_rating, el.kinopoisk,
                el.imdb, el.metacritic, el.rotten_tomatoes]
      end
    end
  end
end
