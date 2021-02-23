ActiveAdmin.register Article do
  permit_params :body, :published, :title, :slug, :published_at

  controller do
    defaults finder: :find_by_slug_or_id
  end
end
