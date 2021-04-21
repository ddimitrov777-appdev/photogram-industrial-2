# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  image          :string
#  comments_count :integer          default(0)
#  likes_count    :integer          default(0)
#  caption        :text
#  owner_id       :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :owner, class_name: "User"
  has_many :comments
  has_many :likes
  has_many :fans, through: :likes

  validates :caption, presence: true
  validates :image, presence: true

  scope :by_likes, -> { order(likes_count: :desc) }
  scope :past_week, -> { where(created_at: 1.week.ago...) }

  def fan_list
    @_fan_list ||= fans.pluck(:username).to_sentence
  end
end
