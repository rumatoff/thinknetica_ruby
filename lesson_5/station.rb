class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = {}

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] << self
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def train_by_type(type)
    trains.select { |train| train.type == type }
  end
end
