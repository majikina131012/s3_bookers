class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true,
    length: { maximum: 200 }
  
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 本日の投稿数をカウント
  scope :posted_today, -> {
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  }

  # 昨日の投稿数をカウント
  scope :posted_yesterday, -> {
    where("created_at >= ? AND created_at < ?", 1.day.ago.beginning_of_day, Time.zone.now.beginning_of_day)
  }
  
  scope :posted_2days_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :posted_3days_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :posted_4days_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :posted_5days_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :posted_6days_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前

  # 今週の投稿数をカウント
  scope :posted_this_week, -> {
    where("created_at >= ?", Time.zone.now.beginning_of_week)
  }

  # 先週の投稿数をカウント
  scope :posted_last_week, -> {
    where("created_at >= ? AND created_at < ?", 1.week.ago.beginning_of_week, Time.zone.now.beginning_of_week)
  }
end
