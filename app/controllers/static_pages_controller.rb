class StaticPagesController < ApplicationController
  respond_to :html, :js

  def home
    if signed_in?
      @projects = current_user.projects.all
      @project = current_user.projects.build
    end
  end
end
