class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    #method that runs search

    if params[:search].present?
      search
    else
      @posts = Post.all
    end
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
      @markers = @posts.geocoded.map do |post|
        {
          lat: post.latitude,
          lng: post.longitude,
          info_window: render_to_string(partial: "info_window", locals: {post: post }),
          post: post
        }
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
  end

  def mins_ago
    start_time = post.date_posted
    end_time = Time.new
    TimeDifference.between(start_time, end_time).in_minutes
  end

  private

  def search
    #saving search
    search_save
    # pg searching string columns address and category
    category_address_string = params[:search].values_at("city", "preferred_district", "category").join(" ")
    @posts = Post.search_strings(category_address_string)

    if params[:search][:max_price].present?
      @posts = @posts.where(price: 0..params[:search][:max_price].to_i).or(@posts.where(price: [nil, ""]))
    end

    if params[:search][:min_size].present?
      @posts = @posts.where(size: params[:search][:min_size].to_i..Float::INFINITY).or(@posts.where(size: [nil, ""]))
    end
  end

  def search_save
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    @search.save
    render :new if !@search.valid?
  end

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :title, :user_id)
  end
end

