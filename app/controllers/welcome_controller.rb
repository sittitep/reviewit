class WelcomeController < ApplicationController
  layout 'welcome'

  def index
    @branches = Branch.all
  end
end
