require 'diary'
require 'diary_entry'
require 'task'
require 'todo_list'

RSpec.describe 'integration' do
  describe '#add' do
    it 'adds an entry to the diary' do
      diary = Diary.new
      diary_entry = DiaryEntry.new("title", "contents")
      expect(diary.add(diary_entry)).to eq [diary_entry]
    end
  end

  describe '#show_entries' do
    it 'shows a list of diary entries' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new("title_1", "contents_1")
      diary_entry_2 = DiaryEntry.new("title_2", "contents_2")
      diary.add(diary_entry_1)
      diary.add(diary_entry_2)
      expect(diary.show_entries).to eq [diary_entry_1, diary_entry_2]
    end
  end

  describe '#count_words' do
    it 'shows the total number of words in all entries' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new("title_1", "this entry contains a number of words")
      diary_entry_2 = DiaryEntry.new("title_2", "this entry has five words")
      diary.add(diary_entry_1)
      diary.add(diary_entry_2)
      expect(diary.count_words).to eq 12
    end
  end

  # describe '#reading_time' do
  #   it 'returns the time needed for all entries to be read' do
  #     diary = Diary.new
  #     diary_entry_1 = DiaryEntry.new("title_1", "this entry contains a number of words")
  #     diary_entry_2 = DiaryEntry.new("title_2", "this entry has exactly six words")
  #     diary.add(diary_entry_1)
  #     diary.add(diary_entry_2)
  #     diary.count_words
  #     expect(diary.reading_time(3)).to eq 5
  #   end
  # end

  describe '#select_entries_to_read' do
    context 'when the wpm is 0' do
      it 'fails' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "one two three four five six")
        diary_entry_2 = DiaryEntry.new("title_2", "one two three four five")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect { diary.select_entries_to_read(0, 5) }.to raise_error "Reading speed must be above zero"
      end
    end

    context 'when the available minutes are zero' do
      it 'fails' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "one two three four five six")
        diary_entry_2 = DiaryEntry.new("title_2", "one two three four five")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect { diary.select_entries_to_read(4, 0) }.to raise_error "You have no time to read right now"
      end
    end

    context 'when both the wpm and minutes variables are reasonable numbers' do
      it 'shows the readable entries at the time' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "one two three four five six")
        diary_entry_2 = DiaryEntry.new("title_2", "one two three four five")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.select_entries_to_read(4, 2)).to eq [diary_entry_1, diary_entry_2]
      end
    end
  end

  describe '#see_contact_numbers' do
    context 'when there is no contact number in the entries' do
      it 'fails' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "one two three")
        diary_entry_2 = DiaryEntry.new("title_2", "hone two three four")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect { diary.see_contact_numbers }.to raise_error "No contact numbers found"
      end
    end

    context 'when there is at least one contact number in the entries' do
      it 'shows a list of all contact numbers' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "one two three")
        diary_entry_2 = DiaryEntry.new("title_2", "his number is 07647382910")
        diary_entry_3 = DiaryEntry.new("title_3", "her number is 07600082910")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        diary.add(diary_entry_3)
        expect(diary.see_contact_numbers).to eq ["07647382910", "07600082910"]
      end
    end

    context 'when there are duplicate numbers' do
      it 'shows each number once' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title", "07600082910")
        diary_entry_2 = DiaryEntry.new("title_2", "his number is 07647382910")
        diary_entry_3 = DiaryEntry.new("title_3", "her number is 07600082910")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        diary.add(diary_entry_3)
        expect(diary.see_contact_numbers).to eq ["07600082910", "07647382910"]
      end
    end
  end

  describe '#add' do
    it 'adds a task to the todo list' do
      todo_list = TodoList.new
      task = Task.new("task")
      expect(todo_list.add(task)).to eq [task]
    end
  end

  describe '#see_tasks' do
    it 'shows a list of all tasks added' do
      todo_list = TodoList.new
      task_1 = Task.new("task 1")
      task_2 = Task.new("task 2")
      todo_list.add(task_1)
      todo_list.add(task_2)
      expect(todo_list.see_tasks).to eq [task_1, task_2]
    end
  end
end
  