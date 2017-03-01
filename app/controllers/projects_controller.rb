class ProjectsController < ApplicationController
before_action :signed_in_user, only: [:create,:destroy, :index, :update ]
before_action :correct_user, only: [:index, :edit, :update, :destroy]


before_action :all_projects, only: [:create, :update, :destroy]
before_action :all_tasks, only: [:create, :update, :destroy]
#before_action :set_projects, only: [:edit,  :destroy]
#before_filter :prepare_user_form, only: [:new]
  respond_to :html, :js





def index
  @projects =current_user.projects
     respond_to do |format|
    format.html
    format.json
  end
end

def new
  @project = Project.new
end


  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      #flash[:success] = "Project created!"
    else
    end
  end

  def update


 respond_to do |format|
    if @project.update_attributes(project_params)
      format.html { redirect_to @project, notice: 'Student was successfully updated.' }
      format.json { respond_with_bip(@project) }
    else
      format.html { render action: "edit" }
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  end

  def destroy
    @project.destroy
  end
=begin
  def destroy
  	@project.destroy
  	redirect_to root_url
  end


	
	
end
  	  def update

    if @project.update_attributes(project_params)
      flash[:success] = "Project title updated"
      redirect_to root_url
    end
  end

  def update
  	@project = Project.find(params[:id])
    @project.update_attributes(project_params)
    redirect_to root_url

  end

  def edit
  	@project = Project.find(params[:id])
  end
=end
  private
def all_projects
  @projects =current_user.projects.all
  
end

def all_tasks
  @tasks =@project.tasks.all
end

#def set_projects
#  @project=Project.find(params[:id])
#  @tasks= @project.tasks
#end



    def project_params
      params.require(:project).permit(:title,:complete)
    end
    
    def correct_user
    	@project = current_user.projects.find_by(id: params[:id])
    	#redirect_to root_url if @project.nil?
    end
end