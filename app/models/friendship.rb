class Friendship < ApplicationRecord

  belongs_to :left_user, :class_name => 'User'
  belongs_to :right_user, :class_name => 'User'

  scope :stateFriends, -> { where(:state => "FRIENDS") }
  scope :statePending, -> { where(:state => "PENDING") }


end
