class WelcomeController < ApplicationController
  layout 'welcome'

  def index
    @posts = Post.order("created_at DESC").first(3)
  end
end
