class LinkItem
  include Listable
  attr_reader :description, :site_name, :type
  attr_accessor :priority

  def initialize(type,url, options={})
    @description = url
    @site_name = options[:site_name]
    @type = type
    fetch_priority(options) if options[:priority]
  end

  def details
    "Site name: #{format_name}"
  end

  private

  def format_name
    @site_name ? @site_name : ""
  end
end
