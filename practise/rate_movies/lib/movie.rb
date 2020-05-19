# frozen_string_literal: true

# Movie class
class Movie
  include Comparable
  attr_reader :title, :kinopoisk, :imdb, :metacritic, :rotten_tomatoes

  def initialize(title, kinopoisk, imdb, metacritic, rotten_tomatoes)
    @title = title
    @kinopoisk = kinopoisk.to_f
    @imdb = imdb.to_f
    @metacritic = metacritic.to_f
    @rotten_tomatoes = rotten_tomatoes.to_f
  end

  def ogon_rating
    res = (@imdb + @kinopoisk + (@metacritic + @rotten_tomatoes) / 2) / 3
    res
  end

  def <=>(other)
    ogon_rating <=> other.ogon_rating
  end

  def to_s
    "Title: #{title} / Kinopoisk: #{kinopoisk} / IMDB: #{imdb}
    Metacritic: #{metacritic} / Rotten Tomatoes: #{rotten_tomatoes}"
  end
end
