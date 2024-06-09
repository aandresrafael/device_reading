class ReadingsController < ApplicationController

  def create
    device_reading = Device.new(params[:device_readings])

    if device_reading.valid? && device_reading.readings_valid?
      device_readings = Rails.cache.read('device_reading') || []

      unless device_readings.any? {|d_reading| d_reading.id == device_reading.id }
        device_readings << device_reading
        Rails.cache.write("device_reading", device_readings)
      end

      render json: device_reading, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def latest
    device_readings = Rails.cache.read('device_reading')
    puts device_readings
    puts params[:device_id]
    device  = device_readings&.find { |device| device.id == params[:device_id]}

    if device
      render json: { latest_timestamp: device.readings.last.timestamp }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def device_count
    device_readings = Rails.cache.read('device_reading')
    device  = device_readings&.find { |device| device.id == params[:device_id] }

    if device
      render json: { cumulative_count: device.cumulative_count }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
