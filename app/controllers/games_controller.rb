class GamesController < ApplicationController
  def new
    @letters = []
    source = ("A".."Z").to_a
    10.times { @letters << source[rand(source.size) - 1].to_s }
  end

  def score
    @letters = params[:original_letters].split("")
    @word = params[:word].upcase
    @english = english?(@word)
    @inclu = included?(@word, @letters)
  end

  private

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    parsing = open(url).read
    info = JSON.parse(parsing)
    info["found"]
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
