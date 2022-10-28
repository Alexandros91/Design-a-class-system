class Diary

  def initialize
    @entries = []
    @readable_entries = []
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
    @entries.filter do |entry|
      if entry.count_words <= wpm * minutes
        @readable_entries << entry
      end
    end
    return @readable_entries
  end

end