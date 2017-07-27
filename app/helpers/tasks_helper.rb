module TasksHelper
  def create_task
    project = Project.find(params[id])
    @task = project.tasks.build
  end
end
