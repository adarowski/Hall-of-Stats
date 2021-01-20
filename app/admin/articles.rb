ActiveAdmin.register Article do
  controller do
    defaults finder: :find_by_slug_or_id
  end
end
