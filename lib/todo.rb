class TodoItem
   include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @type = "todo"
    check_priority options[:priority]
  end

  def check_priority option
    priority_levels = ["high", "low", "medium", nil]
    if priority_levels.include? option
      @priority = option
    else
      raise UdaciListErrors::InvalidPriorityValue, "Invalid priority value!"
    end
  end

  def details
    format_description(@description) + "list type: #{@type}   |" + "due: " + 
    format_date +
    format_priority
  end
end
