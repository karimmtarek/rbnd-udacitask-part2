class UdaciList
  attr_reader :title, :items
  TYPE = %w(todo event link)

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    if TYPE.include? type
      @items.push TodoItem.new(type, description, options) if type == "todo"
      @items.push EventItem.new(type, description, options) if type == "event"
      @items.push LinkItem.new(type, description, options) if type == "link"
    else
      fail(UdaciListErrors::InvalidItemType, "Unsupported item type: '#{type}'.")
    end
  end

  def delete(index)
    if index <= @items.size
      @items.delete_at(index - 1)
    else
      fail(UdaciListErrors::IndexExceedsListSize, "Item with id: '#{index}' not found.")
    end
  end

  def all
    header
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(type)
    filtered_items = @items.select { |item| item.type == type }

    filtered_items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  private

  def header
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
  end
end
