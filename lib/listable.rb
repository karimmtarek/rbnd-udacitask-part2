module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(start_or_due_date: nil, end_date: nil)
    dates = start_or_due_date.strftime("%D") if start_or_due_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" unless dates
    dates
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:magenta) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" unless priority

    value
  end
end
