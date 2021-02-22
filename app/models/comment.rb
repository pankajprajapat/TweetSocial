class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :attachments, as: :attached_item, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }
end
