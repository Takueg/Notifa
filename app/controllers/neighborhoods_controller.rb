class NeighborhoodsController < ApplicationController
  def new
    @neighborhood = Neighborhood.new
  end

  def create
    raise
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.save
    render :new if !@neighborhood.valid?
  end

   def neighborhood_params
    params.require(:neighborhood).permit(:name, :description, :image_url)
  end
end
