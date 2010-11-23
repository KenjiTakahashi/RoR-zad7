class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  def create
    @group = Group.create(params[:group])
    respond_to do |r|
      if @group.save
        @membership = @group.memberships.create(:user_id => current_user.id, :admin => true)
        if @membership.save
          flash[:success] = "Successfully added group"
          r.html { redirect_to root_path }
        else
          @group.delete
          r.html { render :action => "new" }
        end
      else
        r.html { render :action => "new" }
      end
    end
  end
  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @invitation = Invitation.new
    @admins = @group.memberships.where(:admin => true).map { |t| t.user }
    @uninvited = User.all.find_all do |u|
      not @group.invited?(u) and not @group.member?(u) and not @admins.include?(u)
    end
  end
  def invite
    @group = Group.find(params[:id])
    @invitation = Invitation.new(params[:invitation])
    @invitation.update_attributes(:group_id => @group.id)
    respond_to do |r|
      if @invitation.save
        flash[:success] = "Successfully invited user"
        r.html { redirect_to :action => "show" }
      else
        r.html { render :action => "show" }
      end
    end
  end
  def accept
    invitation = Invitation.find(params[:inv])
    @membership = current_user.memberships.new(:group_id => invitation.group_id, :admin => false)
    invitation.delete
    @membership.save if params[:accept]
    redirect_to root_path
  end
end
