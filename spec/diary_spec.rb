require 'diary'

RSpec.describe Diary do
  it 'initially has zero entries' do
    diary = Diary.new
    expect(diary.show_entries).to eq []
  end

  it 'initially has zero number of words' do
    diary = Diary.new
    expect(diary.count_words).to eq 0
  end

  it 'initially has no readable entries' do
    diary = Diary.new
    expect(diary.select_entries_to_read(2, 2)).to eq []
  end

  it 'initially has no contect numbers' do
    diary = Diary.new
    expect { diary.see_contact_numbers }.to raise_error "No contact numbers found"
  end
end