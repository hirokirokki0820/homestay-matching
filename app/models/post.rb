class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  before_create :set_post_id
  geocoded_by :address
  after_validation :geocode #, if: :address_changed?

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, length: { maximum: 2000 }
  validates :address, length: { maximum: 200 }
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                    message: "有効なフォーマットではありません" },
                    size: { less_than: 5.megabytes, message: " 5MBを超える画像はアップロードできません" }

  private
    # ランダムな POST-ID を返す
    def set_post_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
      end
    end

    # 表示用のリサイズ済み画像を返す
    # def display_images
    #   self.images.variant(resize_to_limit: [640, 480])
    # end

end
