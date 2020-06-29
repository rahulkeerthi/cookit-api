class KitsController < ApplicationController
  before_action :set_kit, only: %i[show destroy]

  def index
    @kits = Kit.all
    as_json(@kits, object_to_include: [tags: { only: :name }, restaurant: { only: :name }, photos: { methods: :service_url }])
  end

  def show
    as_json(@kit, object_to_include: [tags: { only: :name }, restaurant: { only: :name }, photos: { methods: :service_url }])
  end

  def update
    if @kit.update(kit_params)
      as_json(@kit, object_to_include: [restaurant: { methods: :tags }, photos: { methods: :service_url }], status: :updated)
    else
      render_error
    end
  end

  def create
    @kit = Kit.new(kit_params)
    if @kit.save
      as_json(@kit, object_to_include: [restaurant: { methods: :tags }, photos: { methods: :service_url }], status: :created)
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
