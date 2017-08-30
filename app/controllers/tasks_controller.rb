
class TasksController < ApplicationController
  require 'date'
	before_action :set_project, only: [:new, :create, :index, :edit, :update]
  respond_to :html, :js

  def new
  		@task = @project.tasks.new
	end

def show
  @tasks = @project.tasks
end


  def create
    #@task = @project.tasks.new(task_params)
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


  def edit
    @task = @project.tasks.find(params[:id])
  end

def update
  @task = @project.tasks.find(params[:id])
  deadline =  task_deadline(params[:deadline])
 respond_to do |format|
    if @task.update(title: params[:title], priority: params[:priority], deadline: deadline)
      format.html { redirect_to root_url }
      format.js
      format.json{render action: 'show',
                         status: :created, location: @task}
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

  def task_deadline(deadline)
    if deadline!= ""
      deadline=DateTime.strptime(deadline, "%m/%d/%Y  %H:%M %p")
    else
      deadline= nil
    end
  end

	def task_params
		task=params[:task].permit(:title, :priority, :deadline)
    task[:deadline]= task_deadline(task[:deadline])
    task
  end



end
