
class TasksController < ApplicationController
  require 'date'
	before_action :set_project, only: [:new, :create, :index, :edit, :update]
  after_action :update_priority, only: [:destroy]
  respond_to :html, :js
  def update_priority
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    i = @deleted_position
    @tasks[(@deleted_position - 1)..-1].each do |n|
      n.update_attributes(position: i)
      i += 1
    end
  end

  def new
  		@task = @project.tasks.new
	end

def show
  @tasks = @project.tasks
end


  def create
    @task = @project.tasks.scope.build(task_params)
    respond_to do |format|
      if @task.save
        @tasks = @project.tasks
        @previous_position = @tasks.length
        @task.update_attributes(:position => @previous_position)
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
    @deleted_position = @task.position
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

  def sort
    params[:order].each do |key,value|
      Task.find(value[:id]).update_attribute(:position, value[:position])
    end
    render :nothing => true
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
