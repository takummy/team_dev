module TeamHelper
  def default_img(image)
    image.presence || 'default.jpg'
  end

  def owner?(assign)
    current_user.id == assign.team.owner_id && !(current_user.id == assign.user.id)
  end
end
