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
    @name_image = "image_#{language}"
    @name_container = "#{language}_container_#{id}"
  end

  # method to copy file keep source submit to container and run
  def run
    run_file_server = "dockerStorage/#{@language}/#{@source}"
    puts run_file_server
    result_file_server = "dockerStorage/#{@language}/result.txt"
    puts result_file_server
    run_file_container = 'runfile.txt'
    puts run_file_container
    result_file_container = 'result.txt'
    puts result_file_container
    run_container = "docker run -d --name #{@name_container} --rm -it #{@name_image} bash"
    puts run_container
    if system(run_container) == false
      1
    else
      byebug
      copy_file(run_file_server, run_file_container, 1)
      copy_file(result_file_server, result_file_container, 1)

      if run_code(run_file_container, result_file_container)
        copy_file(result_file_container, @result, 2)
        return 0
      else
        return 2
      end
    end
  end

  private

  # method to copy file from host to container and reverse
  # source -> string: name source file (not include character /)
  # des -> string: name destination file (not include character /)
  # type: 1-> host to container 2 -> container to host
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
    run_code_command = "docker exec -it #{@name_container} ./script.sh #{runfile} #{result} "
    system(run_code_command)
  end
end

# system("docker run -d --name ruby_container --rm -it testruby bash")