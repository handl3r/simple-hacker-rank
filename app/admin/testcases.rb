# frozen_string_literal: true

ActiveAdmin.register Testcase do
  permit_params :input, :output, :challenge_id
end
