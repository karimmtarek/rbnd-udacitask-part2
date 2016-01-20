require "artii"
require 'terminal-table'

class UdaciList
  attr_reader :title, :items
  TYPE = %w(todo event link)
  TBL_HEADINGS = ['#', 'Content', 'Details', 'Priority', 'Type']

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    if TYPE.include? type
      items.push TodoItem.new(type, description, options) if type == "todo"
      items.push EventItem.new(type, description, options) if type == "event"
      items.push LinkItem.new(type, description, options) if type == "link"
    else
      fail(UdaciListErrors::InvalidItemType, "Unsupported item type: '#{type}'.")
    end
  end

  def delete(index)
    if index <= items.size
      items.delete_at(index - 1)
    else
      fail(UdaciListErrors::IndexExceedsListSize, "Item with id: '#{index}' not found.")
    end
  end

  def all
    print_header(title)

    rows = items.each_with_index.map do |item, position|
      tbl_row_values(position, item)
    end

    puts print_table(headings: TBL_HEADINGS, rows: rows)
  end

  def filter(item_type)
    rows = items
            .select { |item| item.type == item_type }
            .each_with_index
            .map { |item, position| tbl_row_values(position, item) }

    puts print_table(headings: TBL_HEADINGS, rows: rows)
  end

  def find(item_number:)
    if item_number <= items.size
      item = items[item_number - 1]
      rows = []
      rows << tbl_row_values(0, item)

      puts print_table(headings: TBL_HEADINGS, rows: rows)
    else
      fail(UdaciListErrors::IndexExceedsListSize, "Item with number: '#{item_number}' not found.")
    end
  end

  def update_priority(item_number:, priority:)
    if item_number <= items.size
      item = items[item_number - 1]
      item.priority = priority
    else
      fail(UdaciListErrors::IndexExceedsListSize, "Item with number: '#{item_number}' not found.")
    end
  end

  private

  def print_header(header)
    puts Artii::Base.new(font: 'standard').asciify(header)
  end

  def print_table(headings:, rows:)
    Terminal::Table.new(headings: headings, rows: rows)
  end

  def format_priority(priority)
    return " ⇧".colorize(:red) if priority == "high"
    return " ⇨".colorize(:magenta) if priority == "medium"
    return " ⇩".colorize(:green) if priority == "low"
    return "" unless priority
  end

  def tbl_row_values(position, item)
    [position + 1, item.description, item.details, {value: format_priority(item.priority), alignment: :center}, item.type]
  end
end
