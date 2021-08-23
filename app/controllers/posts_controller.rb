class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    #method that runs search
    search

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

  private

  def search
    if params[:search].present?
      # pg searching string columns address and category
      category_address_string = params[:search].values_at("city", "preferred_district", "category").join(" ")
      category_address_array = Post.search_strings(category_address_string)

      #filtering with price and size
      @posts = category_address_array.select do |post|
        post.price < params[:search][:max_price].to_i if post.price
        post.size > params[:search][:min_size].to_i if post.size
      end

    else
      @posts = Post.all
    end
  end

end
