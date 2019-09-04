# frozen_string_literal: true

# This controller for Challenge model
class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show edit update destroy]

  # GET /challenges
  # GET /challenges.json
  def index
    @group_challenges = Groupchallenge.order('id').page(params[:page]).per(1)
    @challenges = Challenge.all
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @testcases = @challenge.testcases
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit; end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def default_code
    @challenge.testcases.each do |testcase|
      
    end
  end

  # Action get request post from test-btn & submit-btn
  def process_post
    # render json: {  status: 'oke', content: params[:content], language: params[:language] }
    # Note 1: user_id can not enough so . must use somthings more like time now to identify file
    # Note 2: Do latter . must add suffix of file to Language table then change this query
    $PATH_TO_STORAGE_FILE = '/my_app/submit_code_result'
    file_result = "result_#{current_user.id}.txt"
    file_code = "#{params[:language]}_#{current_user.id}.rb"
    query_touch_files = "touch #{$PATH_TO_STORAGE_FILE}/#{file_result} #{$PATH_TO_STORAGE_FILE}/#{file_code}"
    if !system(query_touch_files) # if can not make files
      render json: { status: 'fail' }
      0
    else
      file1 = File.open("#{$PATH_TO_STORAGE_FILE}/#{file_code}", "w")
      file1.puts params[:content]
      file1.close
      container = RunContainer.new(params[:language], current_user.id)
      if container.run
        data = File.read("#{$PATH_TO_STORAGE_FILE}/#{file_result}")
        render json: { status: 'oke', content: data }
      else
        return 1
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
  respond_to do |format|
    if @challenge.update(challenge_params)
      format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
      format.json { render :show, status: :ok, location: @challenge }
    else
      format.html { render :edit }
      format.json { render json: @challenge.errors, status: :unprocessable_entity }
    end
  end
end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.fetch(:challenge, {})
  end
end
