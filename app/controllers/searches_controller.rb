class SearchesController < ApplicationController

  def index
    # @searches = Search.all
    @searches = Search.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @search = Search.new
    @search.city = params[:query]
  end

  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    @search.save
    raise
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

  private

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :user_id, :activated)
  end

end
