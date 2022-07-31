class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  before_create :set_post_id
  geocoded_by :address
  after_validation :geocode #, if: :address_changed?

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, length: { maximum: 2000 }
  validates :address, length: { maximum: 200 }

  private
    # ランダムな POST-ID を返す
    def set_post_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
      end
    end

end
