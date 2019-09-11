# frozen_string_literal: true

# This class to check result of code user submit
class Checker
  def initialize(challenge, file_result)
    @challenge = challenge
    @file_result = file_result
  end

  # Method to run check code
  # return array output and he last element is number of right test
  def run
    file1 = IO.readlines("#{$path_to_storage_file}/#{@file_result}")
    temp_i = 0
    right_number = 0
    result = []
    @challenge.testcases.each do |testcase|
      right_number += 1 if testcase.output.delete(" \t\r\n") == file1[temp_i].delete(" \t\r\n")
      result.append(file1[temp_i].rstrip)
      temp_i += 1
    end
    result[temp_i] = right_number
    result
  end
end