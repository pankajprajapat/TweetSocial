class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :attachment, as: :attached_item, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates_presence_of :body
  accepts_nested_attributes_for :attachment, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }
end
