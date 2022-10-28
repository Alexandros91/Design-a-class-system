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
end
  