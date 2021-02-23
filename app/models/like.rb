class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

  # Validations
  validates_presence_of :status
end
