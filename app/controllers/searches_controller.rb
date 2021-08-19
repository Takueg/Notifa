class SearchesController < ApplicationController
  def new
    # @city = params[:city]
    @search = Search.new
    @search.city = params[:query]
  end

  def create
    @search = Search.new(search_params)
  end
end
