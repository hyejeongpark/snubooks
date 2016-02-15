class User < ActiveRecord::Base
  attr_readonly :email

  authenticates_with_sorcery!
  validates :email, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 3}
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true

  has_many :posts, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
end
