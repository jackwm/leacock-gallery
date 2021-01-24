class CalendarExhibit < Exhibit
  def self.applicable_to?(object)
    object.class == Calendar
  end

  exhibit_query :exhibitions
end
