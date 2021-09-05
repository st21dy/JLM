class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :articles, dependent: :destroy
  attachment :icon
  
  validates :body, presence: false, length: { maximum: 50 } 
  # 自己紹介の最高文字数は50文字
  
end
