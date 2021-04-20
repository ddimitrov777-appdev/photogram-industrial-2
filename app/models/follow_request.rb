class FollowRequest < ApplicationRecord
  
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :recipient_id, uniqueness: { scope: :sender_id, message: "already followed" }

  enum status: { pending: "pending", rejected: "rejected", accepted: "accepted" } 
end
