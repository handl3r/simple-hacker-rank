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
    default_code = Successcode.find_by(user: current_user,
                                       language: Language.find_by(name: 'ruby'),
                                       challenge: @challenge)
    if !default_code.nil?
      @default_code = default_code.code
    else
      @default_code = Defaultcode.find_by(challenge: @challenge,
                                          language: Language.find_by(name: 'ruby')).code
    end
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit;
  end

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
    @challenge = Challenge.find_by(id: params[:challenge])
    @language = Language.find_by(name: params[:language])
    default_code = Successcode.find_by(user: current_user,
                                       language: @language,
                                       challenge: @challenge)
    if !default_code.nil?
      @default_code = default_code.code
    else
      @default_code = Defaultcode.find_by(challenge: @challenge,
                                          language: @language).code
    end
    render json: { status: 'success', content: @default_code}
  end

  # Action get request post from test-btn & submit-btn
  def process_post
    # render json: {  status: 'oke', content: params[:content], language: params[:language] }
    # Note 1: user_id can not enough so . must use somethings more like time now to identify file

    @challenge = Challenge.find_by(id: params[:challenge])
    suffix_language = Language.find_by(name: params[:language]).suffix
    $path_to_storage_file = '/my_app/submit_code_result'
    file_result = "result_#{current_user.id}.txt"
    file_code = "#{params[:language]}_#{current_user.id}#{suffix_language}"
    query_touch_files = "touch #{$path_to_storage_file}/#{file_result} #{$path_to_storage_file}/#{file_code}"
    if !system(query_touch_files) # if can not make files
      render json: { status: 'fail' }
      0
    else
      file1 = File.open("#{$path_to_storage_file}/#{file_code}", "w")
      file1.puts params[:content]
      file1.close

      # process file before run
      processor = ProcessorFile.new(file_code, @challenge)
      if params[:language] == 'ruby'
        processor.process_ruby
      elsif params[:language] == 'python3'
        processor.process_python3
        # Call different method to process another languages
      end

      # Make container to run code of user
      container = RunContainer.new(params[:language], current_user.id)
      container.run

      # Checker to check this code be post
      checker = Checker.new(@challenge, file_result)
      result = checker.run

      # response result and save code of user submit if user submit code right
      if params[:submit] == '0' # if user post code to test
        render json: { status: 'check done', content: result }
      elsif params[:submit] == '1' # if submit code to finish this challenge
        if result.last == @challenge.testcases.count # if this code is right
          passlevel = Passlevel.new(user_id: current_user.id, challenge_id: @challenge.id)

          # save passlevel and render response
          check_passlevel(passlevel, result)
          successcode = Successcode.new(user_id: current_user.id,
                                        language: Language.find_by(name: params[:language]),
                                        challenge: @challenge,
                                        code: params[:content])

          #save of update code to success-code
          successcode.check_invalid(params[:content])

          # remove files

        else # if code is not right
          render json: { status: 'submit fail', content: result }
        end
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

  # This method use to render result and message for user
  def check_passlevel(passlevel, result)
    if passlevel.save # if user did not finish this challenge before
      render json: { status: 'submit done', content: result }
    else # if user finished this challenge before
      render json: { status: 're-submit done', content: result }
    end
  end

  #-----------------------------------------------
  # This method to clear files after done jobs.
  # Note : Must fix name of result because if a use test/submit code
  # by a language and then do it with different language
  # -> so result file will be overwrite
  #-----------------------------------------------
  def clear

  end
end
