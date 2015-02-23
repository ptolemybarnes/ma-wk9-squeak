module ReviewsHelper
  
  def star_rating(rating)
    if rating.is_a? Integer
      '★' * rating
    else
      'N/A'
    end
  end

end
