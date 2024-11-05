require 'sidekiq-scheduler'

class FetchArticlesJob
  include Sidekiq::Job

  def perform
    scraper = NewsScraperService.new
    scraper.scrape_all_publishers
  end
end
