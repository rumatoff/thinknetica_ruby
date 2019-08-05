class PassengerTrain < Train

  def initialize(number, type = :passenger)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    register_instance
  end

  def valid_wagon?(wagon)
    wagon.type == type
  end
end
