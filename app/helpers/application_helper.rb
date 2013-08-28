module ApplicationHelper
  def vk_login_link
    link_to image_tag(asset_path('vk_logo.jpg'), alt: 'Sign In via VK'), '/auth/vkontakte', class: 'thumbnail'
  end

  def drop_room_btn
    button_tag 'Drop', class: 'btn btn-danger btn-xs', 'ng-show' => 'currentUser.isMaster(room._id)', 'ng-click' => 'drop(room._id)'
  end
end
