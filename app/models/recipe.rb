class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :recipe_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  #検索
  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(title: content)
    elsif method == 'forward'
      Recipe.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Recipe.where('title LIKE ?', '%' + content)
    else
      Recipe.where('title LIKE ?', '%' + content + '%')
    end
  end
end
