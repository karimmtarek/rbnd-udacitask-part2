class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :type
  attr_accessor :priority

  def initialize(type, description, options={})
    @description = description
    @type = type
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    fetch_priority(options) if options[:priority]
  end

  def details
    "event dates: #{format_date(start_or_due_date: start_date, end_date: end_date)}"
  end
end
