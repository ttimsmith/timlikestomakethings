class Attachment < ActiveRecord::Base
  mount_uploader :file_name, MediaUploader

  # Associations
  belongs_to :post
  belongs_to :comment
end
