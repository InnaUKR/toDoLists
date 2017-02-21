class ProjectsController < ApplicationController
before_action :signed_in_user, only: [:create,:destroy]
before_action :correct_user, only: :destroy


	

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      #flash[:success] = "Project created!"
      	redirect_to root_url
    else
    	@feed_items = []
      	render 'static_pages/home'
    end
  end

  def destroy
  	@project.destroy
  	redirect_to root_url
  end


  	  def update

    if @project.update_attributes(project_params)
      flash[:success] = "Project title updated"
      redirect_to root_url
    end
  end


  private

    def project_params
      params.require(:project).permit(:title)
    end
    
    def correct_user
    	@project = current_user.projects.find_by(id: params[:id])
    	redirect_to root_url if @project.nil?
    end
end