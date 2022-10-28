class DiaryEntry

  attr_reader :title, :contents

  def initialize(title, contents)
    @title = title
    @contents = contents
  end

  def count_words
    @contents.split.length
  end
  
  def reading_time(wpm)
    (count_words / wpm.to_f).ceil
  end
end