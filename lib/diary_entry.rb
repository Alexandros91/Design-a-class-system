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
    raise "Reading speed must be above zero" if wpm <= 0
    (count_words / wpm.to_f).ceil
  end
end