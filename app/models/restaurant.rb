class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :user, presence: true
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if self.reviews.empty?
    self.reviews.inject(0) {|sum, review| sum + review.rating } / self.reviews.count
  end
end
