require "artii"
require 'terminal-table'

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
      [position + 1, item.description, item.details, item.type]
    end

    puts print_table(headings: ['#', 'Content', 'Details', 'Type'], rows: rows)
  end

  def filter(item_type)
    rows = items
            .select { |item| item.type == item_type }
            .each_with_index
            .map { |item, position| [position + 1, item.description, item.details, item.type] }

    puts print_table(headings: ['#', 'Content', 'Details', 'Type'], rows: rows)
  end

  private

  def print_header(header)
    puts Artii::Base.new(font: 'standard').asciify(header)
  end

  def print_table(headings:, rows:)
    Terminal::Table.new(headings: headings, rows: rows)
  end
end
