class HomeController < ApplicationController
  def index
    @groups = Group.all
    if user_signed_in?
      indexes = Membership.where(:user_id => current_user.id, :admin => true).map { |m| m.group_id }
      @owned_groups = Group.where(:id => indexes)
      #yeah, yeah
      indexes = Membership.where(:user_id => current_user.id, :admin => false).map { |m| m.group_id }
      @member_groups = Group.where(:id => indexes)
      @invitations = current_user.invitations
      @membership = Membership.new
    end
  end
end
