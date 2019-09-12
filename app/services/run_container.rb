# frozen_string_literal: true

# Image for each language must be built before
# Class to run a container when server receive code form user be saved
# call from controller
class RunContainer
  SOURCE = 'run_file.rb'
  DES = 'result.rb'
  # This constant must be redefine on server
  $submit_code_result_folder = '/home/thai/www/RailsPR/Project2/submit_code_result'
  TEMP_CONTAINER_FOLDER = '/app'

  # language -> string: to run corresponded container  with language request
  # id -> integer : identify for user
  def initialize(language, id)
    @language = language
    @name_image = "#{language}_image"
    @name_container = "#{language}_container_#{id}"
    suffix_language = Language.find_by(name: language).suffix
    @run_file = "#{language}_#{id}#{suffix_language}"
    @result = "result_#{id}.txt"
  end

  # main method to run a container and run code inside it
  def run
    byebug
    run_container = "docker run -d -it --rm --name #{@name_container} -v #{$submit_code_result_folder}:#{TEMP_CONTAINER_FOLDER}   #{@name_image} bash"
    byebug
    if !system(run_container)
      byebug
      false
    else
      byebug
      run_code(@run_file, @result)
      byebug
      # then stop container
      system("docker stop #{@name_container}")
      true
    end
  end

  private

  # method to run code form file on container and save result
  # runfile : string -> name file keep code to run (not include character /)
  # result : string -> name file to save result (not include character /)
  def run_code(runfile, result)
    run_code_command = "docker exec -it #{@name_container} script.sh #{@language} #{runfile} #{result} "
    system(run_code_command)
  end
end
