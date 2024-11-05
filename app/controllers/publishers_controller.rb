class PublishersController < ApplicationController
  def index
    publishers = Publisher.all
    render json: publishers
  end

  def create
    publisher = Publisher.new(publisher_params)
    if publisher.save
      render json: publisher, status: :created
    else
      render json: publisher.errors, status: :unprocessable_entity
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :language, :rss_feed_url, :website_url)
  end
end
