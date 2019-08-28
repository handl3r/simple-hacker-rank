# frozen_string_literal: true

class RunContainer
  # Class to run a container for each request test or submit, call from controller
  # language -> string : to run container correspond with language request
  # source -> string : name file to keep source submit (like x_id1.rb not include character /)
  # id -> integer : identify for user and user's container
  # result -> name file to get result return (not include character /)
  def initialize(language, source, result, id)
    @source = source
    @result = result
    @language = language
    @name_image = "project2_#{language}_image"
    @name_container = "project2_#{language}_container" # add _#{id} in the end when dont test
  end

  # method to copy file keep source submit to container and run
  def run
    path_to_submit_folder = '/home/thai/www/RailsPR/Project2/submit_code_result'
    run_file_container = 'test.rb'
    result_file_container = 'result.txt'
    # image was build yet
    run_container = "docker run -d -it --rm --name #{@name_container} -v #{path_to_submit_folder}:/app   #{@name_image} bash"
    if system(run_container) == false
      false
    else
      run_code(run_file_container, result_file_container)
      # then stop container
      system("docker stop #{@name_container}")
    end
  end

  private

  # method to copy file from host to container and reverse
  # source -> string: name source file (not include character /)
  # des -> string: name destination file (not include character /)
  # type: 1-> host to container (exactly main container to other container), 2 -> container to host(reverse)
  def copy_file(source, des, type)
    copy_file_command = ''
    if type == 1
      copy_file_command = "docker cp #{source} #{@name_container}:/app/#{des}"
    elsif type == 2
      copy_file_command = "docker cp #{@name_container}:/app/#{source} ../../dockerStorage/#{@language}/#{des}"
    end
    system(copy_file_command)
  end

  # method to run code form file on container and save result
  # runfile : string -> name file keep code to run (not include character /)
  # result : string -> name file to save result (not include character /)
  def run_code(runfile, result)
    run_code_command = "docker exec -it #{@name_container} script.sh #{@language} #{runfile} #{result} "
    system(run_code_command)
  end
end

# system("docker run -d --name ruby_container --rm -it testruby bash")