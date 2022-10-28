class TodoList
  
  def initialize
    @task_list = []
  end

  def add(task)
    @task_list << task
  end
  
  def see_tasks
    @task_list
  end

end
