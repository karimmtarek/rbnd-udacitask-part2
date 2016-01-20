class TodoItem
  include Listable
  attr_reader :description, :due, :type
  attr_accessor :priority

  def initialize(type, description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @type = type
    fetch_priority(options) if options[:priority]
  end

  def details
    "due: #{format_date(start_or_due_date: due)}"
  end
end
