ActiveAdmin.register Successcode do
  permit_params :user_id, :challenge_id, :language_id, :code
end
