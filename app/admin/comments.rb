# frozen_string_literal: true

ActiveAdmin.register Comment do
  permit_params :user_id, :post_id, :content
end
