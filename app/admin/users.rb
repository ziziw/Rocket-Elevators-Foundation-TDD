ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :email, :password, :token, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :function
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :password, :token, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :function]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :first_name, :last_name, :email, :password

  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
