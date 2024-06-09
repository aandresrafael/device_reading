require 'rails_helper'

describe ReadingsController, type: :controller do
  let(:params) do
    {
      "id": "36d5658a-6908-479e-887e-a949ec199272",
      "readings": [
        {
          "timestamp": "2021-09-29T16:08:15+01:00",
          "count": 2
        },
        {
          "timestamp": "2021-09-29T16:09:15+01:00",
          "count": 123
        }
      ]
    }
  end

  describe '#create' do
    it 'should return status 200' do
      post :create, params: { device_readings: params }
      expect(response.status).to eq(200)
    end

    it 'should avoid duplicated readings with same id' do
      post :create, params: { device_readings: params }
      post :create, params: { device_readings: params }

      expect(response.status).to eq(200)
      expect(Rails.cache.fetch('device_reading').size).to eq(1)

    end

    it 'should return invalid data request' do
      bad_request = {"id": "36d5658a-6908-479e-887e-a949ec199272"}
      post :create, params: { device_readings: bad_request }
      expect(response.status).to eq(422)
    end
  end

  describe '#latest' do
    it 'should return status 200' do
      post :create, params: { device_readings: params }
      get :latest, params: { device_id: '36d5658a-6908-479e-887e-a949ec199272' }

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["latest_timestamp"]).to eq("2021-09-29T16:09:15+01:00")
    end

    it 'should return not found' do
      Rails.cache.clear
      get :latest, params: { device_id: '36d5658a-6908-479e-887e-a949ec199272' }

      expect(response.status).to eq(404)
    end
  end

  describe '#device_count' do
    it 'should return status 200' do
      post :create, params: { device_readings: params }
      get :device_count, params: { device_id: '36d5658a-6908-479e-887e-a949ec199272' }

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["cumulative_count"]).to eq(125)
    end

    it 'should return not found' do
      Rails.cache.clear
      get :device_count, params: { device_id: '36d5658a-6908-479e-887e-a949ec199272' }

      expect(response.status).to eq(404)
    end
  end

end
