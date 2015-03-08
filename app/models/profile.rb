class Profile < ActiveRecord::Base
  belongs_to :user

  # take our picture column (string) in the db
  # treat it like PicUploader wants us to treat it
  mount_uploader :picture, PicUploader
end
