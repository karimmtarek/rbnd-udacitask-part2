class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :priority
  PRIORITY_VALUES = %(low medium high)

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    fetch_priority(options) if options[:priority]
  end

  def details
    format_description(description) + "due: " +
    format_date(start_or_due_date: due) +
    format_priority(priority)
  end

  private

  def fetch_priority(options)
    priority = options[:priority].downcase

    if PRIORITY_VALUES.include? priority
      @priority = options[:priority]
    else
      fail(InvalidPriorityValue, "Invalid priority value: '#{priority}'.")
    end
  end
end
