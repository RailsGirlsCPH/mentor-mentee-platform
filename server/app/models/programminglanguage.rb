class Programminglanguage < ApplicationRecord
  has_many :wishes
  validates_presence_of :language
end
