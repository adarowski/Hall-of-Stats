ActiveAdmin.register Article do
  controller do
    with_role :admin
    defaults finder: :find_by_slug_or_id
  end
end
