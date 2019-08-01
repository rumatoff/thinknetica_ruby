class Train
  attr_reader :number, :type

  def initialize(number, type, wagons = 20)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def accelerate(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def move?
    true if @speed.positive?
  end

  def add_wagon
    @wagons += 1 unless move?
  end

  def remove_wagon
    @wagons -= 1 unless move? || @wagons.zero?
  end

  def add_route(route)
    @route = route
    @route.stations[0].take_train(self)
  end

  def current_station
    @route.stations.find { |station| station.trains.include?(self) }
  end

  def previous_station
    if start_station?
      false
    else
      @route.stations[@route.stations.index(current_station) - 1]
    end
  end

  def next_station
    if last_station?
      false
    else
      @route.stations[@route.stations.index(current_station) + 1]
    end
  end

  def forward
    if last_station?
      false
    else
      station = next_station
      move(station)
    end
  end

  def backward
    if start_station?
      false
    else
      station = previous_station
      move(station)
    end
  end

  def last_station?
    current_station == @route.stations[-1]
  end

  def start_station?
    current_station == @route.stations[0]
  end

  def move(station)
    current_station.send_train(self)
    station.take_train(self)
  end
end
