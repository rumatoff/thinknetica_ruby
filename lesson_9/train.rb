# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :wagons, :route, :type

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/.freeze

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    validate!
    @@trains[number] = self
    register_instance
  end

  def accelerate(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if valid_wagon?(wagon) && !move?
  end

  def remove_wagon(wagon_number)
    raise 'Номер вагона не может быть пустым' if wagon_number.nil?

    wagon = select_wagon(wagon_number)
    raise 'Вагон с таким номером не найден' if wagon.nil?

    @wagons.delete(wagon) unless move? || @wagons.count.zero?
  end

  def select_wagon(wagon_number)
    wagons.find { |wagon| wagon.number == wagon_number }
  end

  def add_route(route)
    @route = route
    @route.stations[0].take_train(self)
  end

  def current_station
    @route.stations.find { |station| station.trains.include?(self) }
  end

  def previous_station
    if current_station == @route.stations[0]
      false
    else
      @route.stations[@route.stations.index(current_station) - 1]
    end
  end

  def next_station
    if current_station == @route.stations[-1]
      false
    else
      @route.stations[@route.stations.index(current_station) + 1]
    end
  end

  def forward
    if next_station
      station = next_station
      move(station)
    else
      false
    end
  end

  def backward
    if previous_station
      station = previous_station
      move(station)
    else
      false
    end
  end

  def move?
    true if @speed.positive?
  end

  def valid?
    true if validate!
  rescue StandardError
    false
  end

  def valid_wagon?(wagon)
    wagon.type == type
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) } if block_given?
  end

  private

  attr_writer :wagons, :speed

  def move(station)
    current_station.send_train(self)
    station.take_train(self)
  end

  def validate!
    raise "Номер #{number} не соотвествует формату" if number !~ NUMBER_FORMAT
  end
end
