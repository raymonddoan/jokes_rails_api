class Joke < ApplicationRecord
  belongs_to :category

  # Search the category based on the input provided
  def self.find_by_category(input)
    category = Category.find_by(name: input.capitalize)

    # Returning itself (aka. the joke) - using self since we are searching within the joke record
    return self.where(category: category)
  end
  
end
