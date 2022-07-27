class Post < ApplicationRecord
  belongs_to :user
  before_create :set_post_id

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { maximum: 2000 }
end



private
  # ランダムな POST-ID を返す
  def set_post_id
    while self.id.blank? || User.find_by(id: self.id).present? do
      self.id = SecureRandom.base58
    end
  end
