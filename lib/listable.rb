module Listable
  # Listable methods go here
  def format_description description
    description.ljust 30
  end

  def format_date
  	dates = @due ? @due.strftime("%D") : "No due date"
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates

    return dates
  end

  def format_priority
    value = " ⇧ ".colorize(:red).on_blue if @priority == "high"
    value = " ⇨ ".colorize(:white).on_blue if @priority == "medium"
    value = " ⇩ ".colorize(:yellow).on_blue if @priority == "low"
    value = "" if !@priority
    return value
  end
end
