class Post < ApplicationRecord
  belongs_to :user
  has_many :attachments, as: :attached_item, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum status: { 'Draft' => 0, 'Published' => 1 }

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }
end
