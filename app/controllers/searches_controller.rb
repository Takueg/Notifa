class SearchesController < ApplicationController
  def new
    # @city = params[:city]
    @search = Search.new
  end
end
