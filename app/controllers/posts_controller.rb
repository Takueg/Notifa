class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index]

  def index
    #method that runs search
    search

    @posts = Post.all
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
      @markers = @posts.geocoded.map do |post|
        {
          lat: post.latitude,
          lng: post.longitude,
          info_window: render_to_string(partial: "info_window", locals: {post: post })
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
      #saving search
      search_save
      # pg searching string columns address and category
      category_address_string = params[:search].values_at("city", "preferred_district", "category").join(" ")
      category_address_array = Post.search_strings(category_address_string)

      #filtering with price and size
      @posts = []

      category_address_array.each do |post|
        if post.price && post.price < params[:search][:max_price].to_i
          if post.size && post.size > params[:search][:min_size].to_i
            @posts << post
          end
        end
      end
    else
      @posts = Post.where(params[:search][:city])
    end
    raise
  end

  def search_save
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    @search.save
    render :new if !@search.valid?
  end

  def search_params
    params.require(:search).permit(:city, :preferred_district, :max_price,
      :min_size, :room, :category, :frequency, :user_id)
  end
end
