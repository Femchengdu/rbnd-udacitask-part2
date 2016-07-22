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
  
  def all 
    formating_title
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
