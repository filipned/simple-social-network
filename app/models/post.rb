class Post < ActiveRecord::Base
	has_many :comments, dependent: :delete_all
	belongs_to :user
	validates :title, presence: true,
						length: {minimum: 5}

						
end
