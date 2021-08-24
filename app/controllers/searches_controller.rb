class SearchesController < ApplicationController

  def index
    # @searches = Search.all
    @searches = Search.where(user_id: current_user.id)
  end

  def search_list
    @searchlist = current_user.searches.find(params[:id])
  end

  def new
    # @city = params[:city]
    @search = Search.new
  end
end


# class MoviesController < ApplicationController
#   def index
#     if params[:query].present?
#       @movies = Movie.where(title: params[:query])
#     else
#       @movies = Movie.all
#     end
#   end
# end

