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
end