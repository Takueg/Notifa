class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    @posts = Post.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude
      }
    end
    raise
  end

  def show
    @posts = Post.find(params[:id])
  end
end
