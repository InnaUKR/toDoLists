class StaticPagesController < ApplicationController
  respond_to :html, :js

  def home
    if signed_in?
    	@project  = current_user.projects.build
      	@projects = current_user.projects.all
    end

  end

  def about
  end
end
