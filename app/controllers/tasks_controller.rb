class TasksController < ApplicationController
	before_action :set_project, only: [:new,:create]
  respond_to :html, :js
	def new
  		@task = @project.tasks.build
	end

def show
  @tasks = @project.tasks
end


  def create
    @task = @project.tasks.build(task_params)
    if @task.save
    end
  end

def update
 respond_to do |format|
 	@task=Task.find_by_id(params[:id])
    if @task.update_attributes(task_params)
      format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      format.json { respond_with_bip(@task) }
    else
      format.html { render action: "edit" }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  end

  def destroy
    @task.destroy
  end

	private
	def set_project
		@project = Project.find(params[:project_id])
	end

	def task_params
		params[:task].permit(:title)
	end


end
