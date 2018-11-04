class Package < ApplicationRecord
  has_many :builds
  has_many :arches, through: :builds

  validates :name,
    presence: true,
    uniqueness: true
  validates :license, presence: true
  validates :version, presence: true
  validates :revision,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
