require 'open-uri'
require 'nokogiri'
require "pry-byebug"

class ParseHtmlService
  attr_reader :url, :squad

  def initialize(attrs = {})
    @url = attrs[:url]
    @squad = attrs[:squad]
  end

  def call
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    binding.pry
  end
end


# http://res.cloudinary.com/dmbf29/image/upload/78pyio19vku20jpbarskk66dulkg
url = "https://res.cloudinary.com/dmbf29/raw/upload/v1675667301/development/78pyio19vku20jpbarskk66dulkg.html"
ParseHtmlService.new(url: url, squad: Squad.find(13)).call
