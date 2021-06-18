class Category < ApplicationRecord
  has_many :jokes, class_name: "joke", foreign_key: "reference_id"
end
