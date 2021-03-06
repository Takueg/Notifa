class SearchesController < ApplicationController

  def index
    @searches = Search.where(user_id: current_user.id)
    # @searches = Search.where(user_id: current_user.id).includes(:posts)
  end

  def new
    @search = Search.new
    @search.city = params[:query]
    @neighborhoods = Neighborhood.all
  end

  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    @search.save
    render :new if !@search.valid?
  end

  def edit
    @search = Search.find(params[:id])
  end

  def update
    @search = Search.find(params[:id])
      if @search.update(search_params)
        redirect_back fallback_location: searches_path
      else
        render :edit
      end
  end

  def show
    @search = Search.find(params[:id])
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to searches_path
  end

  private

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :user_id, :activated)
  end

end
