ActiveAdmin.register Post do
  permit_params :user_id, :category_post_id, :content
end
