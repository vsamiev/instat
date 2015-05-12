class API::InstatsController < ApplicationController
  before_action :set_api_instat, only: [:show, :update, :destroy]


  # GET /api/instats/1
  # GET /api/instats/1.json
  def show
    if @player
      render json: @player
    else
      render nothing: true, status: 404
    end
  end

  # POST /api/instats
  # POST /api/instats.json
  def create

    job = DataLoader.perform_async(params["data"])
    render json: {job_id: job}, status: 201

    # result = Instat.save_data(params["data"])
    # if result
    #   render json: result, status: 201
    # else
    #   render nothing: true, status: 422
    # end
  end

  private

  def set_api_instat
    @player = Player.find_by(id: params[:id])
  end

  def api_instat_params
    params[:api_instat]
  end
end
