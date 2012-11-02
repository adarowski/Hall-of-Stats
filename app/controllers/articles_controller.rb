class ArticlesController < ApplicationController
  def index
    @articles = Article.published.by_published_at.limit(25)
  end

  def show
    @article = Article.find(params[:id])
    @articles = Article.published.by_published_at
  end
end
