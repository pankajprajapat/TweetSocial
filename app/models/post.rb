class Post < ApplicationRecord
  belongs_to :user
  has_one :attachment, as: :attached_item, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  enum status: { 'Draft' => 0, 'Published' => 1 }
  validates_presence_of :tweet
  accepts_nested_attributes_for :attachment, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].nil? }
  scope :published, -> { where(status: 1) }
end
