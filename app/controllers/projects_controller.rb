class ProjectsController < ApplicationController
  before_action :signed_in_user, only: %i[create destroy index update]
  before_action :correct_user, only: %i[index edit update destroy create]
  before_action :all_projects, only: %i[create update destroy]
  respond_to :html, :js

  def index
    @projects = current_user.projects
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { }
    end
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.save
    respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to @project, notice: 'Student was successfully updated.' }
        format.json { respond_with_bip(@project) }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  private

  def all_projects
    @projects = current_user.projects.all
  end

  def all_taskts
    @tasks = @project.tasks.all
  end

  def project_params
    params.require(:project).permit(:title)
  end

  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
  end
end
