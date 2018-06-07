class User < ActiveRecord::Base
	has_many :posts, dependent: :delete_all
	validates :password, confirmation: true

	has_many :left_user_associations, :foreign_key => :left_user_id, :class_name => "Friendship"

	has_many :left_associations, :through => :left_user_associations, :source => :right_user

	has_many :right_user_associations, :foreign_key => :right_user_id, :class_name => "Friendship"

	has_many :right_associations, :through => :right_user_associations, :source => :left_user

	has_one :token


  def self.isFriends(user1, user2)
    @blabla = Friendship.stateFriends.where("left_user_id = ? AND right_user_id = ?", user1[:id], user2[:id])
    return Friendship.exists?(@blabla)
	end

	def allAssociations
		(left_associations + right_associations).uniq
	end

end
