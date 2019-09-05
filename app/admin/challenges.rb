ActiveAdmin.register Challenge do
  permit_params :title, :content, :question, :groupchallenge_id
end
