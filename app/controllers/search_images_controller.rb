class SearchImagesController < ApplicationController
  before_action :set_search_image, only: [:show, :edit, :update, :destroy]

  # GET /search_images
  # GET /search_images.json
  def index
    @search_images = SearchImage.all
  end

  # GET /search_images/1
  # GET /search_images/1.json
  def show
  end

  # GET /search_images/new
  def new
    @search_image = SearchImage.new
  end

  # GET /search_images/1/edit
  def edit
  end

  # POST /search_images
  # POST /search_images.json
  def create
    @search_image = SearchImage.new(search_image_params)

    respond_to do |format|
      if @search_image.save
        format.html { redirect_to @search_image, notice: 'Search image was successfully created.' }
        format.json { render :show, status: :created, location: @search_image }
      else
        format.html { render :new }
        format.json { render json: @search_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_images/1
  # PATCH/PUT /search_images/1.json
  def update
    respond_to do |format|
      if @search_image.update(search_image_params)
        format.html { redirect_to @search_image, notice: 'Search image was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_image }
      else
        format.html { render :edit }
        format.json { render json: @search_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_images/1
  # DELETE /search_images/1.json
  def destroy
    @search_image.destroy
    respond_to do |format|
      format.html { redirect_to search_images_url, notice: 'Search image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_image
      @search_image = SearchImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_image_params
      params.fetch(:search_image, {})
    end
end
