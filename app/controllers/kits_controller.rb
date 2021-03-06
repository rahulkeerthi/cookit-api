class KitsController < ApplicationController
  before_action :set_kit, only: %i[show related_by_tag related_by_restaurant destroy]

  def index
    @kits = Kit.all
    as_json(@kits, methods_to_invoke: [:restaurant_photos, :tag_names, :service_urls], object_to_include: [restaurant: { only: :name}])
  end

  def show
    as_json(@kit, methods_to_invoke: [:restaurant_photos, :tag_names, :service_urls], object_to_include: [restaurant: { methods: :tags }])
  end

  def update
    if @kit.update(kit_params)
      as_json(@kit, object_to_include: [restaurant: { methods: :tags }, photos: { methods: :service_url }], status: :updated)
    else
      render_error
    end
  end

  def related_by_tag
    tags = @kit.tags
    similar_kits = Hash.new(0)

    tags.each do |tag|
      tag.kits.each do |kit|
        similar_kits[kit] += 1 unless kit == @kit
      end
    end

    most_similar_kits = similar_kits.sort_by { |k,v| -v }

    related_by_tag = most_similar_kits.slice!(0,3).to_h.keys

    as_json(related_by_tag, methods_to_invoke: [:restaurant_photos, :tag_names, :service_urls])
  end

  def related_by_restaurant
    @restaurant = @kit.restaurant
    @restaurant_kits = @restaurant.kits
    as_json(@restaurant_kits, methods_to_invoke: [:restaurant_photos, :tag_names, :service_urls])
  end

  def create
    @kit = Kit.new(kit_params)
    if @kit.save
      as_json(@kit, methods_to_invoke: [:restaurant_photos, :tag_names, :service_urls], status: :created)
    else
      render_error
    end
  end

  def destroy
    @kit.destroy
    render :deleted
  end

  private

  def kit_params
    params.require(:kit).permit(:name, :description, :ingredients, :link_url, :price, :restaurant_id, tags: [], photos: [])
  end

  def render_error
    render json: { errors: @kit.errors.full_messages }, status: :unprocessable_entity
  end

  def set_kit
    @kit = Kit.find(params[:id])
  end
end
