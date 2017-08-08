class TasksController < ApplicationController
	before_action :set_project, only: [:new, :create, :index, :update ]
  respond_to :html, :js

  def new
  		@task = @project.tasks.new
	end

def show
  @tasks = @project.tasks
end


  def create
    @task = @project.tasks.scope.build(task_params)
    #@task = @project.tasks.build(task_params)
    #@task.save
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_url }
        format.js
        format.json{render action: 'show',
                           status: :created, location: @task}
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors,
                             status: :unprocessable_entity }
      end
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
    #@projects = current_users.projects
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy

      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
        format.js   { render :layout => false }
      end
  end

  def complete
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task[:complete] == false
      @task.update_attribute(:complete, true)
    else
      @task.update_attribute(:complete, false)
    end
    respond_to do |format|
      format.html { redirect_to root_url}
      format.json { head :no_content }
      format.js   { render :layout => false }
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
