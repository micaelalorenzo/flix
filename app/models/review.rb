class Review < ApplicationRecord
  
  STARS = [1, 2, 3, 4, 5]
  
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 4 }

  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }


  scope :past_n_days, -> (n = 3){ where("created_at >= ?",  n.days.ago) }

  def stars_as_percent
    (stars / 5.0) * 100
  end

end
