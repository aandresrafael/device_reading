require 'rails_helper'

describe Reading do
  describe 'validation' do
    it 'should be valid object' do
      reading = Reading.new({ "timestamp": "2021-09-29T16:08:15+01:00", "count": 2 })

      expect(reading).to be_valid
    end

    it 'should be invalid object' do
      reading = Reading.new({ "timestamp": "2021-09-29T16:08:15+01:00" })

      expect(reading).to_not be_valid
    end

    it 'should be invalid object' do
      reading = Reading.new({"count": 2 })

      expect(reading.invalid?).to be_truthy
    end
  end
end
