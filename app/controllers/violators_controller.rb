class ViolatorsController < ApplicationController

  def autocomplete
    @violators = Violator.order(:license).where("license like ?", "%#{params[:term]}%")
    render json: { :options => @violators.map(&:license) }.to_json
  end

  # GET /violators
  # GET /violators.json
  def index
    @violators = Violator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @violators }
    end
  end

  # GET /violators/1
  # GET /violators/1.json
  def show
    @violator = Violator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @violator }
    end
  end

  # GET /violators/new
  # GET /violators/new.json
  def new
    @violator = Violator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @violator }
    end
  end

  # GET /violators/1/edit
  def edit
    @violator = Violator.find(params[:id])
  end

  # POST /violators
  # POST /violators.json
  def create
    @violator = Violator.new(params[:violator])

    respond_to do |format|
      if @violator.save
        format.html { redirect_to @violator, notice: 'Violator was successfully created.' }
        format.json { render json: @violator, status: :created, location: @violator }
      else
        format.html { render action: "new" }
        format.json { render json: @violator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /violators/1
  # PUT /violators/1.json
  def update
    @violator = Violator.find(params[:id])

    respond_to do |format|
      if @violator.update_attributes(params[:violator])
        format.html { redirect_to @violator, notice: 'Violator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @violator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /violators/1
  # DELETE /violators/1.json
  def destroy
    @violator = Violator.find(params[:id])
    @violator.destroy

    respond_to do |format|
      format.html { redirect_to violators_url }
      format.json { head :no_content }
    end
  end
end
