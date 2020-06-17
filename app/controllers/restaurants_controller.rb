class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show destroy]

  def index
    @restaurants = Restaurant.all
    as_json(@restaurants, [:kits, :tags, photos: { methods: :service_url }, logo: { methods: :service_url }]) # you can use any of photos, logo, photos_blob, or logo_blob
  end

  def show
    as_json(@restaurant, [:kits, :tags, photos: { methods: :service_url }, logo: { methods: :service_url }])
  end


  def update
    if @restaurant.update(restaurant_params)
      as_json(@restaurant, [:kits, :tags, photos: { methods: :service_url }, logo: { methods: :service_url }], :updated)
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      as_json(@restaurant, [:kits, :tags, photos: { methods: :service_url }, logo: { methods: :service_url }], :created)
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    render :deleted
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :city, :postcode, :address1, :address2, :delivery_options, :email, :twitter, :facebook, :instagram, :website_url, :contact_name, :logo, photos: [])
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
