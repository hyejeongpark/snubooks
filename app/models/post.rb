class Post < ActiveRecord::Base
  belongs_to(:user)
  has_many :favorites, :dependent => :destroy

  validates(:title, :presence => true)
  validates(:contact, :presence => true)
  validates(:user_id, :presence => true)

  mount_uploader :picture, PictureUploader

  self.per_page = 6

  def trade_type_string
    @@trade_types[trade_type]
  end

  def update_time_string
    updated_at.localtime("+09:00").strftime("%Y-%m-%d / %I:%M:%S %p")
  end

  def picture_url
    if picture.url.to_s.length > 0
      return picture.url
    else
      return "noimage.png"
    end
  end

  private

  @@trade_types = {1 => "SELL", 2 => "BUY", 3 => "LEND", 4 => "BORROW"}
end
