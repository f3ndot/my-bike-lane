class ViolationsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_violation, :only => [:show]

  def up_vote
    violation = Violation.find(params[:id])
    begin
      vote = current_user.vote_for violation
      render json: {status: 'upvoted', message: 'Successfully up-voted', vote: vote}
    rescue ActiveRecord::RecordInvalid
      render json: {status: 'error', message: 'You have already up-voted this violation'}
    end
  end

  def down_vote
    violation = Violation.find(params[:id])
    begin
      vote = current_user.vote_against violation
      render json: {status: 'downvoted', message: 'Successfully down-voted', vote: vote}
    rescue ActiveRecord::RecordInvalid
      render json: {status: 'error', message: 'You have already down-voted this violation'}
    end
  end

  def un_vote
    violation = Violation.find(params[:id])
    begin
      vote = current_user.unvote_for violation
      render json: {status: 'unvoted', message: 'Successfully removed your vote', vote: vote}
    rescue ActiveRecord::RecordInvalid
      render json: {status: 'error', message: 'You have already undone your vote'}
    end
  end


  # GET /violations
  # GET /violations.json
  def index
    @violations = Violation.without_spammed.order("created_at DESC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @violations }
    end
  end

  def heatmap
    @violations = Violation.without_spammed.where('longitude IS NOT ? OR longitude IS NOT ?', nil, nil).order("created_at DESC")
  end

  def flagged
    @violations = Violation.where(:flagged => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @violations }
    end
  end

  def spammed
    @violations = Violation.only_spammed
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
    @violation.build_violator

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @violation }
    end
  end

  # GET /violations/1/edit
  def edit
    @violation = Violation.find(params[:id])
    @violation.photos.build if @violation.photos.count == 0
    @violation.build_violator if @violation.violator.nil?
  end

  def flag
    @violation = Violation.find(params[:id])
    @violation.flagged = true

    respond_to do |format|
      if @violation.save
        FlagMailer.flag(@violation, current_user).deliver
        format.html { redirect_to @violation, notice: 'Violation has been flagged for review.' }
        format.json { render json: @violation, status: :flagged, location: @violation }
      else
        format.html { render action: "flag" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  def unflag
    @violation = Violation.find(params[:id])
    @violation.flagged = false

    respond_to do |format|
      if @violation.save
        format.html { redirect_to :back, notice: 'Violation is no longer flagged.' }
        format.json { render json: @violation, status: :unflagged, location: @violation }
      else
        format.html { render action: "unflag" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  def spam
    @violation = Violation.find(params[:id])
    @violation.spammed = true
    respond_to do |format|
      if @violation.save
        @violation.spam!
        format.html { redirect_to '/', notice: 'Violation is marked as spam.' }
        format.json { render json: @violation, status: :spam, location: '/' }
      else
        format.html { render action: "spam" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  def ham
    @violation = Violation.only_spammed.find(params[:id])
    @violation.spammed = false
    respond_to do |format|
      if @violation.save
        @violation.ham!
        format.html { redirect_to :back, notice: 'Violation is no longer marked as spam.' }
        format.json { render json: @violation, status: :ham, location: @violation }
      else
        format.html { render action: "ham" }
        format.json { render json: @violation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /violations
  # POST /violations.json
  def create
    @violation = Violation.new(params[:violation])

    # dirty hack to get the new or existing violator and save it with the provided attributes
    if params[:violation][:violator_attributes][:license].present?
      @violation.license_plate = params[:violation][:violator_attributes][:license]
      @violation.violator.update_attributes params[:violation][:violator_attributes]
    end

    @violation.user = current_user unless current_user.nil?

    @violation.user_ip = request.remote_ip
    @violation.user_agent = request.env['HTTP_USER_AGENT']
    @violation.referrer = request.referrer
    @violation.spammed = @violation.spam?

    respond_to do |format|
      if @violation.save
        if @violation.spammed == true
          FlagMailer.spam(@violation, current_user).deliver
          format.html { redirect_to '/', alert: 'Sorry but your submission was detected as spam. The admin will manually verify shortly.' }
          format.json { render json: @violation, status: :spam, location: '/' }
        else
          format.html { redirect_to @violation, notice: 'Violation was successfully created.' }
          format.json { render json: @violation, status: :created, location: @violation }
        end
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

    # dirty hack to get the new or existing violator and save it with the provided attributes
    if params[:violation][:violator_attributes][:license].present?
      @violation.license_plate = params[:violation][:violator_attributes][:license]
      @violation.violator.update_attributes params[:violation][:violator_attributes]
    end

    @violation.user_ip = request.remote_ip
    @violation.user_agent = request.env['HTTP_USER_AGENT']
    @violation.referrer = request.referrer

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
