class ViolationsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_violation, :only => [:show]

  # GET /violations
  # GET /violations.json
  def index
    @violations = Violation.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @violations }
    end
  end

  # GET /violations/1
  # GET /violations/1.json
  def show
    @violation = Violation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @violation }
    end
  end

  # GET /violations/new
  # GET /violations/new.json
  def new
    @violation = Violation.new
    @violation.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @violation }
    end
  end

  # GET /violations/1/edit
  def edit
    @violation = Violation.find(params[:id])
    @violation.photos.build
  end

  def flag
    @violation = Violation.find(params[:id])
    @violation.flagged = true
    @violation.save!
    FlagMailer.flag(@violation, current_user).deliver

    render json: {result: "ok"}
  end

  # POST /violations
  # POST /violations.json
  def create
    @violation = Violation.new(params[:violation])
    @violation.user = current_user unless current_user.nil?

    respond_to do |format|
      if @violation.save
        format.html { redirect_to @violation, notice: 'Violation was successfully created.' }
        format.json { render json: @violation, status: :created, location: @violation }
      else
        @violation.photos.build
        format.html { render action: "new" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /violations/1
  # PUT /violations/1.json
  def update
    @violation = Violation.find(params[:id])

    respond_to do |format|
      if @violation.update_attributes(params[:violation])
        format.html { redirect_to @violation, notice: 'Violation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /violations/1
  # DELETE /violations/1.json
  def destroy
    @violation = Violation.find(params[:id])
    @violation.destroy

    respond_to do |format|
      format.html { redirect_to violations_url }
      format.json { head :no_content }
    end
  end

  protected

  def find_violation
    @violation = Violation.find params[:id]

    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the violation_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != violation_path(@violation)
      return redirect_to violation_path(@violation), :status => :moved_permanently
    end
  end

end
