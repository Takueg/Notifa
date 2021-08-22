class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    if params[:search].present?
      # pg searching string columns address and category
      category_address_string = params[:search].values_at("city", "preferred_district", "category").join(" ")
      category_address = Post.search_strings(category_address_string)
      + Post.where("price <  ?", params[:search][:max_price])
      + Post.where("size >  ?", params[:search][:min_size])
      + Post.where("room >  ?", params[:search][:room])
      @posts = search_results.uniq
    else
      @posts = Post.all
    end

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude
      }
    end
  end

  def show
    @posts = Post.find(params[:id])
  end

  def create
  end

end
