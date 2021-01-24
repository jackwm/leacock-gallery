require 'cgi'

class Exhibition

  # Data schema
  # -----------
  #

  include DataMapper::Resource

  has n, :artists,
    through: Resource

  property :id, Serial
  timestamps :at

  property :title, String,
    length: 200,
    required: true
  property :slug, Slug,
    required: true,
    default: ->(r,p){ r.title },
    unique: true
  property :details, Text
  property :start_date, Date,
    required: true
  property :end_date, Date,
    default: ->(r,p){ r.start_date }
  property :location, String,
    length: 200


  # Domain logic
  # ------------
  #

  attr_accessor :calendar

  def schedule
    return false unless valid?
    calendar.add_exhibition(self)
  end

  def update(attrs)
    calendar.update_exhibition(self, attrs)
  end

  def cancel
    calendar.destroy_exhibition(self)
  end

  def details?
    !details.nil?
  end

  def after?(date)
    start_date > date and end_date > date
  end

  def before?(date)
    start_date < date and end_date < date
  end

  def includes?(date)
    start_date < date and end_date > date
  end

  def location?
    !location.nil?
  end

  def self.future(date=DateTime.now)
    all(:start_date.gte => date, :end_date.gte => date)
  end

  def self.past(date=DateTime.now)
    all(:start_date.lte => date, :end_date.lte => date)
  end

  def self.current(date=DateTime.now)
    all(:start_date.lte => date, :end_date.gte => date)
  end

  def self.most_relevant(date=DateTime.now)
    current(date).first or future(date).first or past(date).first
  end

  def snippet(sentence, word_count, overflow='&#8230;')
    last = sentence.index(' ', word_count)
    if sentence.length <= word_count || last.nil?
      sentence
    else
      sentence[0...last] + overflow.to_s
    end
  end

  def googlize(location)
    "https://maps.google.com/?q=" + CGI.escape(location)
  end

end
