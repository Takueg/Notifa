class SearchesController < ApplicationController

  def index
    @searches = Search.all
  end

  def new
    # @city = params[:city]
    @search = Search.new
  end
end
