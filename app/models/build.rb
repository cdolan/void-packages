class Build < ApplicationRecord
  belongs_to :arch
  belongs_to :package

  validates :filename_sha256, presence: true
  validates :filename_size,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :installed_size,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
