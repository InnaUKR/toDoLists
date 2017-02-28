class TasksController < ApplicationController
	before_action :set_project, only: [:new,:create]
  respond_to :html, :js
	def new
  		@task = @project.tasks.build
	end

def show
  @tasks = @project.tasks
  @id = @project.id
end


  def create
    @task = @project.tasks.build(task_params)
    if @task.save
    end
  end

	private
	def set_project
		@project = Project.find(params[:project_id])
	end

	def task_params
		params[:task].permit(:title)
	end


end
