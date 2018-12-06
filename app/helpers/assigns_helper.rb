module AssignsHelper
  def owner_or_yourself(assign)
    current_user.id == assign.team.owner_id || current_user.id == assign.user.id
  end
end