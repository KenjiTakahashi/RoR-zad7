class Group < ActiveRecord::Base
  validates_presence_of :name, :desc
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :invitations, :dependent => :destroy

  def member?(user)
    users.include?(user)
  end
  def invited?(user)
    invitations.map { |t| t.user_id }.include?(user.id)
  end
end
