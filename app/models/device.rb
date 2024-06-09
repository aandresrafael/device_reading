class Device
  include ActiveModel::Validations

  attr_accessor :id, :readings

  validates_presence_of :id, :readings

  def initialize(params)
    self.id = params[:id]
    load_readings(params[:readings])
  end

  def load_readings(readings)
    self.readings = readings&.map { |reading| Reading.new(reading) }
  end

  def readings_valid?
   !self.readings.any? {|reading| reading.invalid? }
  end

  def cumulative_count
    self.readings.inject(0) { |sum, reading| sum += reading.count.to_i }
  end

end
