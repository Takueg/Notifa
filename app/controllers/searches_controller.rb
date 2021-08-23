class SearchesController < ApplicationController

  # def index
  #   @searches = Search.all
  # end

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

  private

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :user_id)
  end

end
