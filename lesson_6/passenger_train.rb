class PassengerTrain < Train

  def initialize(number, type = :passenger)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    validate!
    @@trains[number] = self
    register_instance
  end

  def valid_wagon?(wagon)
    wagon.type == type
  end
end
