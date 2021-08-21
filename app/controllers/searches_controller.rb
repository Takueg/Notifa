class SearchesController < ApplicationController

  def index
  end

  def new
    @search = Search.new
    @search.city = params[:query]
  end

  def create
    @search = Search.new(search_params)
    @search.user_id = current_user
    if @search.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :user_id)
  end

end
