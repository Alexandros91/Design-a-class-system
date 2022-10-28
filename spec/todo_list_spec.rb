require 'todo_list'

RSpec.describe TodoList do
  it 'initially has an empty list of tasks' do
    todo_list = TodoList.new
    expect(todo_list.see_tasks).to eq []
  end
end