class ArticlesController < ApplicationController
  def index
    @articles = Article.published.by_published_at.limit(25)
  end

  def show
    @article = Article.find_by_slug_or_id(params[:id])
    @articles = Article.published.by_published_at
  end
end
