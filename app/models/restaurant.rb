class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :user, presence: true
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if self.reviews.empty?
    self.reviews.average(:rating)
  end

  def destroy_as(user)
    return false unless self.user == user
    destroy
    true
  end

end
