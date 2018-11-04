class Arch < ApplicationRecord
  has_many :builds
  has_many :packages, through: :builds

  validates :name, presence: true, uniqueness: true
end
