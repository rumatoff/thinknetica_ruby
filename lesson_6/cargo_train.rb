class CargoTrain < Train

  def initialize(number, type = :cargo)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    validate!
    @@trains[number] = self
    register_instance
  end
end
