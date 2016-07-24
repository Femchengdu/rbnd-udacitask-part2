class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    types = ["todo", "event", "link"]
    @items.push TodoItem.new(description, options) if type == "todo" 
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    raise UdaciListErrors::InvalidItemType, "Invalid list type!" if !types.include? type
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "You have entered an invalid index!" if index > @items.count
    @items.delete_at(index - 1)
  end

  # Formats the output from the items selected by type
  def filter type
    filtered_items = get_items type
    unless filtered_items == []
      formating_title
      filtered_items.each_with_index do |item, position|
      puts "#{position + 1} #{item.details}"
      end
    else
      raise UdaciListErrors::InvalidType, "You have entered an invalid type!"
    end
  end

  # Selects items from the items array by type
  def get_items type
    @items.select do |item|
      item.type == type
    end
  end

  # Format the title
  def formating_title
    unless @title == nil
      puts "-" * @title.length
      puts @title
      puts "-" * @title.length
    else
      puts " "
      puts "-" * 10 + " Untitled list " + "-" * 10
      puts " "
    end
  end
  # Listing the items
  def all 
    formating_title
    @items.each_with_index do |item, position|
      puts "#{position + 1} #{item.details}"
    end
  end
  # Listing the items using 'table_print' to format the output
  def all_with_table_print
    formating_title
    tp @items, "type", "description"
  end
end
