require 'rails_helper'

describe ReviewsHelper, :type => :helper do

  context '#star_rating' do
    
    it 'returns N/A for a non-integer' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars when passed 5' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end
  end
end
      
