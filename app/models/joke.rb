class Joke < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  # Search the category based on the input provided
  def self.find_by_category(input)
    category = Category.find_by(name: input.capitalize)

    # Returning itself (aka. the joke) - using self since we are searching within the joke record
    return self.where(category: category)
  end

  def transform_joke
    return {
      author: self.user.username,
      category: self.category.name,
      body: self.body,
      posted: self.created_at,
      edited: self.updated_at
    }
  end
  
  
end
