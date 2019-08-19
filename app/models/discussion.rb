class Discussion < ApplicationRecord
  belongs_to :forum
  has_many :replies
end
