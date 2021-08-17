class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    @posts = Post.all
  end

  def show
    @posts = Post.find(params[:id])
  end
end
