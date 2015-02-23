require 'rails_helper'

describe ReviewsHelper, :type => :helper do

  context '#star_rating' do
    
    it 'returns N/A for a non-integer' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars when passed 5' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'supplements black stars with white when passed less than 5' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns 4 black and 1 white star when passed 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end
end
      
