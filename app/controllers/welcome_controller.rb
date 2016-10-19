require 'chess_toolkit'

class WelcomeController < ApplicationController
  def index
    @graph = CtGraph.new
  end
end
