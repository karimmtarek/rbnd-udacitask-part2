class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type
  PRIORITY_VALUES = %(low medium high)

  def initialize(type, description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @type = type
    fetch_priority(options) if options[:priority]
  end

  def details
    format_description(description, type) + "due: " +
    format_date(start_or_due_date: due) +
    format_priority(priority)
  end

  private

  def fetch_priority(options)
    priority = options[:priority].downcase

    if PRIORITY_VALUES.include? priority
      @priority = options[:priority]
    else
      fail(UdaciListErrors::InvalidPriorityValue, "Invalid priority value: '#{priority}'.")
    end
  end
end
