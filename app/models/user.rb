class User < ApplicationRecord
  before_create :set_id

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, presence: true,
                      length: { minimum: 6 },
                      allow_nil: true


# 渡された文字列のハッシュ値を返す
def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

private
  # メールアドレスを全て小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # ランダムなユーザーIDを返す
  def set_id
    while self.id.blank? || User.find_by(id: self.id).present? do
      self.id = SecureRandom.base58
    end
  end

end
