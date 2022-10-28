require 'task'

RSpec.describe Task do
  it 'constructs' do
    task = Task.new("Clean the balcony")
    expect(task.title).to eq "Clean the balcony"
  end

end