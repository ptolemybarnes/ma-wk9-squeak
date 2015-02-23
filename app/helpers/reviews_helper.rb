module ReviewsHelper
  
  def star_rating(rating)
    if rating.is_a? Numeric
      ('★' * rating.round) + ('☆' * (5 - rating.round))
    else
      'N/A'
    end
  end

end
