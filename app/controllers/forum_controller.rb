# frozen_string_literal: true

class ForumController < ApplicationController
  def home
    @posts = Post.all.order('id').page(params[:page]).per(10)
  end
end
