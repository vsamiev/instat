class API::InstatsController < ApplicationController
  before_action :set_api_instat, only: [:show, :update, :destroy]

  # GET /api/instats
  # GET /api/instats.json
  def index
    @api_instats = API::Instat.all

    render json: @api_instats
  end

  # GET /api/instats/1
  # GET /api/instats/1.json
  def show
    render json: @api_instat
  end

  # POST /api/instats
  # POST /api/instats.json
  def create
    @api_instat = API::Instat.new(api_instat_params)

    if @api_instat.save
      render json: @api_instat, status: :created, location: @api_instat
    else
      render json: @api_instat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/instats/1
  # PATCH/PUT /api/instats/1.json
  def update
    @api_instat = API::Instat.find(params[:id])

    if @api_instat.update(api_instat_params)
      head :no_content
    else
      render json: @api_instat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/instats/1
  # DELETE /api/instats/1.json
  def destroy
    @api_instat.destroy

    head :no_content
  end

  private

    def set_api_instat
      @api_instat = API::Instat.find(params[:id])
    end

    def api_instat_params
      params[:api_instat]
    end
end
