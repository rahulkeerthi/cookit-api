class KitsController < ApplicationController
  before_action :set_kit, only: %i[show destroy]

  def index
    @kits = Kit.all
    as_json(@kits, %i[restaurant tags])
  end

  def show
    as_json(@kit, %i[restaurant tags])
  end

  def update
    if @kit.update(kit_params)
      as_json(@kit, %i[restaurant tags], :updated)
    else
      render_error
    end
  end

  def create
    @kit = Kit.new(kit_params)
    if @kit.save
      as_json(@kit, %i[restaurant tags], :created)
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
    params.require(:kit).permit(:name, :description, :ingredients, :link_url, :price, :restaurant_id)
  end

  def render_error
    render json: { errors: @kit.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_kit
    @kit = Kit.find(params[:id])
  end
end
