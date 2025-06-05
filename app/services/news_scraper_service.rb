require 'rss'
require 'open-uri'
require 'nokogiri'
require 'date'

class NewsScraperService
  def initialize
    @placeholder_image_url = "http://localhost:3000/assets/placeholder-image.png"
  end

  def scrape_all_publishers
    Publisher.find_each do |publisher|
      puts "Scraping articles for #{publisher.name}..."
      begin
        articles = fetch_articles_for_publisher(publisher)
        store_articles(articles, publisher)
      rescue StandardError => e
        # Log the error and skip to the next publisher
        puts "ERROR: Failed to scrape articles for #{publisher.name}: #{e.message}"
        next
      end
    end
  end

  private

  def fetch_articles_for_publisher(publisher)
    puts "Fetching articles for #{publisher.name}..."
    articles = []
    URI.open(publisher.rss_url) do |rss|
      feed = RSS::Parser.parse(rss, false)
      feed.items.each do |item|
        articles << {
          title: item.title,
          main_image: extract_image_url(item),
          published_date: DateTime.parse(item.pubDate.to_s),
          link: item.link
        }
      end
    end
    articles
  end

  def store_articles(articles, publisher)
    puts "Storing articles in DB for #{publisher.name}..."
    articles.each do |article_data|
      Article.create!(
        title: article_data[:title],
        main_image: article_data[:main_image],
        published_date: article_data[:published_date],
        link: article_data[:link],
        publisher: publisher
      )
    end
  end

  def extract_image_url(item)
    # Convert the item to an XML structure for Nokogiri parsing
    item_xml = Nokogiri::XML(item.to_s)

    begin
      # Locate the `media:content` tag and extract the URL from `url` attribute
      media_content = item_xml.at_xpath("//media:content")
      return media_content ? media_content['url'] : @placeholder_image_url
    rescue StandardError => e
      return @placeholder_image_url
    end
  end
end