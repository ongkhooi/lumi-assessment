class NewsController < ApplicationController
  def index
    if params[:language].present?
      publishers = Publisher.where(language: params[:language])
      @articles = Article.where(publisher: publishers).order(published_date: :desc)
    else
      @articles = Article.order(published_date: :desc)
    end

    if @articles.empty?
      render json: { error: "No articles available at this moment" }, status: :not_found
    else
      render json: @articles
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
end
