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
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
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
    items.select { |item| item.type == type }
  end

  private

  def header
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
  end
end
