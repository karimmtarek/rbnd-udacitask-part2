module Listable
  PRIORITY_VALUES = %(low medium high)

  def format_date(start_or_due_date: nil, end_date: nil)
    dates = start_or_due_date.strftime("%D") if start_or_due_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates || no_date
  end

  def no_date
    return "No due date" if self.type == "todo"
    "N/A"
  end

  def fetch_priority(options)
    priority = options[:priority].downcase

    if PRIORITY_VALUES.include? priority
      @priority = options[:priority]
    else
      fail(UdaciListErrors::InvalidPriorityValue, "Invalid priority value: '#{priority}'.")
    end
  end
end
