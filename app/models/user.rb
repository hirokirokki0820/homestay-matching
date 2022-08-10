class User < ApplicationRecord
  attr_accessor :remember_token, :remember_me, :activation_token, :reset_token
  has_many :posts, dependent: :destroy
  has_one_attached :avatar
  before_create :set_id, :set_account_name, :create_activation_digest
  before_save :downcase_email

  # validates :account_type, presence: true, on: :create

  validates :name, presence: true, length: { maximum: 50 }

  validates :avatar, content_type: { in: %w[image/jpeg image/gif image/png],
                    message: "有効なフォーマットではありません" },
                    size: { less_than: 5.megabytes, message: " 5MBを超える画像はアップロードできません" }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, presence: true,
                      length: { minimum: 6 },
                      allow_nil: true

  VALID_ACCOUNT_NAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :account_name, presence: true,
                        uniqueness: true,
                        length: { minimum:3, maximum: 50 },
                        format: { with: VALID_ACCOUNT_NAME_REGEX }, on: :update

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムな記憶トークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
    update_attribute(:activation_sent_at, Time.zone.now)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化リンクの有効期限が切れている場合はtrueを返す
  def activation_expired?
    activation_sent_at < 24.hours.ago
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  def password_reset_expired?
    reset_sent_at < 1.hour.ago
  end

  def to_param
    account_name
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

  # ランダムなアカウント名を返す
  def set_account_name
    while self.account_name.blank? || User.find_by(account_name: self.account_name).present? do
      self.account_name = SecureRandom.base36
    end
  end

  # 有効化トークンとダイジェストを作成及び代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
