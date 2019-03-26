require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
  @grid =  Array.new(26) { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @word_response = open(url).read
    @response_hash = JSON.parse(@word_response)
    if @response_hash[:found]
      @message = "It is an english word"
      @score = @word.length*5
    else
      @message = "It is not an english word"
      @score = 0
    end
    @grid = params[:grid].split(' ')
    if @grid.permutation(@word.length).to_a.include?(@word.upcase.split(""))
      @score = (5 * @word.length)
      @message = "well done!"
    else
      @score = 0
      @message = "not in the grid"
    end
  end
end
