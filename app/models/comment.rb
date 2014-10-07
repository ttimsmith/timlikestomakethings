class Comment < ActiveRecord::Base

  #Associations
  belongs_to :post
  belongs_to :user

  has_many :attachments, dependent: :destroy
end
