module UsersHelper

  def freeze_or_reactivate_button(user)
    if current_user.admin and not user.admin
      if user.suspended
        link_to "reactivate account", toggle_suspension_user_path(user.id), method: :post, class:"btn btn-danger btn-sm"
      else
        link_to "freeze account", toggle_suspension_user_path(user.id), method: :post, class:"btn btn-danger btn-sm"
      end
    end
  end

end