class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show destroy]

  def index
    @restaurants = Restaurant.all
    as_json(@restaurants, %i[kits tags])
  end

  def show
    as_json(@restaurant, %i[kits tags])
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :city, :postcode, :address1, :address2, :delivery_options, :email, :twitter, :facebook, :instagram, :website_url, :contact_name)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
