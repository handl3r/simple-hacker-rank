# frozen_string_literal: true

# This class use to process file before run
class ProcessorFile
  def initialize(file_code, challenge)
    @file = "#{$path_to_storage_file}/#{file_code}"
    @challenge = challenge
  end

  # Process file ruby: append some command test with testcase to file
  def process_ruby
    file1 = File.open(@file, 'a')
    @challenge.testcases.each do |testcase|
      args = testcase.input
      call_method = "\nputs mainMethod(#{args}).to_s" # this must be fix when support languages
      file1.puts call_method
    end
    file1.close
  end

  # Process file python3: append some command test with testcase to file
  def process_python3
    file1 = File.open(@file, 'a')
    @challenge.testcases.each do |testcase|
      args = testcase.input
      call_method = "\nprint(mainMethod(#{args}))"
      file1.puts call_method
    end
    file1.close
  end

  # Process file go
  def process_golang
    file1 = File.open(@file, 'a')
    @challenge.testcases.each do |testcase|
      args = testcase.input
      call_method = "\nfmt.Println(mainMethod(#{args}) \n"
      file1.puts call_method
    end
    file1.close
  end
end