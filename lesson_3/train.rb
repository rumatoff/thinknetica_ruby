class Train
  attr_reader :number, :type
  attr_accessor :speed, :wagons, :route
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def accelerate(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def move?
    true if self.speed.positive?
  end

  def add_wagon
    self.wagons += 1 unless move?
  end

  def remove_wagon
    self.wagons -= 1 unless move? || self.wagons.zero?
  end

  def add_route(route)
    self.route = route
    route.stations[0].take_train(self)
  end

  def current_station
    route.stations.find { |station| station.trains.include?(self) }
  end

  def previous_station
    route.stations[route.stations.index(current_station) - 1]
  end

  def next_station
    route.stations[route.stations.index(current_station) + 1]
  end

  def forward
    station = next_station
    current_station.send_train(self)
    station.take_train(self)
  end

  def backward
    station = previous_station
    current_station.send_train(self)
    station.take_train(self)
  end
end
