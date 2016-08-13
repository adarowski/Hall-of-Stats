ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  controller do
    with_role :admin
    def create
      @user = AdminUser.new(permitted_params[:admin_user])
      if @user.save
        redirect_to admin_admin_user_path(@user)
      end
    end

    def update
      @user = AdminUser.find(params[:id])
      if @user.update(permitted_params[:admin_user])
        redirect_to admin_admin_user_path(@user)
      end
    end
  end

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    actions
  end
end
