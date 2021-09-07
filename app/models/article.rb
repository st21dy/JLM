class Article < ApplicationRecord
  
  belongs_to :user
  attachment :image
  
  mount_uploader :video, VideoUploader
  
  validates :title, :video, :body, presence: true
  
  
end
