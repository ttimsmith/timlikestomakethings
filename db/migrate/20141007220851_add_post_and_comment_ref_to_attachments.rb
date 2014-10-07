class AddPostAndCommentRefToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :post, index: true
    add_reference :attachments, :comment, index: true
  end
end
