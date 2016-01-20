module Listable
  # def format_description(description, type)
  #   "[#{type}] #{description.ljust(30)}"
  # end

  def format_date(start_or_due_date: nil, end_date: nil)
    dates = start_or_due_date.strftime("%D") if start_or_due_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates || no_date
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:magenta) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" unless priority

    value
  end

  def no_date
    return "No due date" if self.type == "todo"
    "N/A"
  end
end
