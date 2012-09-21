ActiveAdmin.register Article do
  controller do
    with_role :admin
  end
end
