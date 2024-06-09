require 'rails_helper'

describe Device do

  describe 'validation' do
    it 'should be valid object' do
      device = Device.new({
        "id": "36d5658a-6908-479e-887e-a949ec199272",
        "readings": [
          {
            "timestamp": "2021-09-29T16:08:15+01:00",
            "count": 2
          },
          {
            "timestamp": "2021-09-29T16:09:15+01:00",
            "count": 2
          }
        ]
      })

      expect(device).to be_valid
    end

    it 'should be invalid object' do
      device = Device.new({
        "readings": [
          {
            "timestamp": "2021-09-29T16:08:15+01:00",
            "count": 2
          },
          {
            "timestamp": "2021-09-29T16:09:15+01:00"
          }
        ]
      })

      expect(device).to_not be_valid
    end

    it 'should be invalid object' do
      device = Device.new({
        "id": "36d5658a-6908-479e-887e-a949ec199272",
      })

      expect(device).to_not be_valid
    end
  end

  describe 'cumulative_count' do
    it 'should sum the readings count for a device' do

      device = Device.new({
        "id": "36d5658a-6908-479e-887e-a949ec199272",
        "readings": [
          {
            "timestamp": "2021-09-29T16:08:15+01:00",
            "count": 123
          },
          {
            "timestamp": "2021-09-29T16:09:15+01:00",
            "count": 22
          }
        ]
      })
      expect(device.cumulative_count).to eq(145)
    end

    it 'should sum the readings count for a device if count is nil or incorrect number' do
      device = Device.new({
        "id": "36d5658a-6908-479e-887e-a949ec199272",
        "readings": [
          {
            "timestamp": "2021-09-29T16:08:15+01:00",
            "count": nil
          },
          {
            "timestamp": "2021-09-29T16:09:15+01:00",
            "count": "abc"
          }
        ]
      })
      expect(device.cumulative_count).to eq(0)
    end
  end
end

