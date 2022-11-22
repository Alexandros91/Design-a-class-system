class Diary

  def initialize
    @entries = []
    @readable_entries = []
    @mobile_numbers = []
  end

  def add(entry)
    @entries << entry
  end
  
  def show_entries
    @entries
  end

  def count_words
    @entries.map do |entry|
      entry.count_words
    end.sum
  end

  # def reading_time(wpm)
  #   (count_words / wpm.to_f).ceil
  # end

  def select_entries_to_read(wpm, minutes)
    raise "Reading speed must be above zero" if wpm <= 0
    raise "You have no time to read right now" if minutes <= 0
    @entries.filter do |entry|
      if entry.count_words <= wpm * minutes
        @readable_entries << entry
      end
    end
    return @readable_entries
  end

  def see_contact_numbers
    @mobile_numbers = @entries.map do |entry|
      extract_numbers_from_entry(entry) 
    end.flatten
    raise "No contact numbers found" if @mobile_numbers == []
    return @mobile_numbers
  end

  private

  def extract_numbers_from_entry(entry)
    return entry.contents.scan(/0[0-9]{10}/)
  end

end