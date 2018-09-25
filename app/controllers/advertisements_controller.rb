class AdvertisementsController < ApplicationController
  before_action :find_advertisement, only: %i[show update destroy]

  def index
    authorize Advertisement

    advertisements = policy_scope(Advertisement).all

    render json: {data: advertisements.as_json(representation: :basic)}, status: 200
  end

  def show
    render json: {data: @advertisement.as_json(representation: :basic)}, status: 200
  end

  def create
    @advertisement = Advertisement.new(create_params)
    authorize @advertisement

    if @advertisement.save
      render json: {data: @advertisement.as_json(representation: :basic)}, status: 201
    else
      render json: {errors: @advertisement.errors.details}, status: 422
    end
  end

  def update
    if @advertisement.update(update_params)
      render json: {}, status: 204
    else
      render json: {errors: @advertisement.errors.details}, status: 422
    end
  end

  def destroy
    if @advertisement.destroy
      render json: {}, status: 204
    else
      render json: {errors: @advertisement.errors.details}, status: 409
    end
  end

  #
  ## PRIVATE METHODS
  #
  private

  def find_advertisement
    @advertisement = Advertisement.find(params[:id])
    authorize @advertisement
  end

  def create_params
    params
      .require(:data)
      .permit(policy(Advertisement).permitted_attributes_for_create)
  end

  def update_params
    params
      .require(:data)
      .permit(policy(@advertisement).permitted_attributes_for_update)
  end

  def current_user
    params[:admin_token] || nil
  end
end
