require 'open-uri'
require 'nokogiri'

class WebRecipe
  attr_reader :recipes, :filepath

  def initialize
    @web_classes = { title:       '.card__title',
                     description: '.card__summary',
                     rating:      '.review-star-text',
                     prep_times:  '.card__titleLink' }
  end

  def load_recipes(keyword)
    #basepath = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/support'
    @filepath = File.join(__dir__, "#{keyword}.html")
    url = "https://www.allrecipes.com/search/results/?search=#{keyword}"

    File.open(@filepath, 'wb') { |file| file << URI.open(url).read } unless File.exist?(@filepath)
    parse
  end

  def parse
    @doc = Nokogiri::HTML(File.open(@filepath), nil, "utf-8")

    @recipes = Array.new(5).map.with_index do |_recipe, i|
      Recipe.new(
        @doc.search(@web_classes[:title])[i].text.strip,
        @doc.search(@web_classes[:description])[i].text.strip,
        @doc.search(@web_classes[:rating])[i].text.strip.match(/Rating: (.*) stars/)[1],
        prep_time(i))
    end
  end

  private

  def prep_time(i)
    item = @doc.search(@web_classes[:prep_times])
    return "-" if item.size <= i
    url = item[i].attribute('href').value
    return "-" unless url
    recipedoc = Nokogiri::HTML(URI.open(url).read)
    return "-" unless recipedoc
    recipedoc.search(".recipe-meta-item:contains('prep')").text.strip[6..-1]
  end
end
