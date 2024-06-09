class Reading
  include ActiveModel::Validations
  attr_accessor :timestamp, :count

  validates_presence_of :timestamp, :count

  def initialize(attrs)
    self.timestamp = attrs[:timestamp]
    self.count = attrs[:count]
  end
end
