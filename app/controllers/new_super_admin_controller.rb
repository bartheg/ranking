class NewSuperAdminController < Devise::RegistrationsController

  def render(*args)
    super("pages/new_super_admin")
  end

end
