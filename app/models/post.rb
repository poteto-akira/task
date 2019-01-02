class Post < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :content, length: { maximum: 300 }
  validates :current_state, presence: true, length: { maximum: 3 }, length: { minimum: 0 }
  validates :user_id, presence: true
  belongs_to :user

  def self.search(search)
    if search
      Post.where(['name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

  def self.state(state)
    Post.where(['current_state LIKE ?', "%#{state}%"])
  end

end
