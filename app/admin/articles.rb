ActiveAdmin.register Article do
  permit_params :title, :body, :published, :slug,
    :"published_at(1i)", :"published_at(2i)", :"published_at(3i)",
    :"published_at(4i)", :"published_at(5i)"

  controller do
    with_role :admin
    defaults finder: :find_by_slug_or_id

    def create
      @article = Article.new(permitted_params[:article])
      if @article.save
        redirect_to admin_article_path(@article)
      end
    end

    def update
      @article = Article.find_by(slug: params[:id])
      if @article.update(permitted_params[:article])
        redirect_to admin_article_path(@article)
      end
    end
  end
end
