require 'diary_entry'

RSpec.describe DiaryEntry do
  it 'constructs' do
    diary_entry = DiaryEntry.new("my_title", "my_contents")
    expect(diary_entry.title).to eq "my_title"
    expect(diary_entry.contents).to eq "my_contents"
  end

  describe '#count_words' do
    it 'returns the number of words in an entry\'s contents' do
      diary_entry = DiaryEntry.new("title", "these are my contents")
      diary_entry.contents
      expect(diary_entry.count_words).to eq 4
    end
  end

  describe '#reading_time' do
    context 'when reading time is not positive number' do
      it 'fails' do
        diary_entry = DiaryEntry.new("title", "contents " * 500)
        diary_entry.contents
        diary_entry.count_words
        expect { diary_entry.reading_time(0) }.to raise_error "Reading speed must be above zero"
      end
    end

    context 'when the wpm is a reasonable number' do 
      it 'returns the number of minutes needed for reading' do
        diary_entry = DiaryEntry.new("title", "contents " * 500)
        diary_entry.contents
        diary_entry.count_words
        expect(diary_entry.reading_time(150)).to eq 4
      end
    end
  end
end
