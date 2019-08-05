class CargoTrain < Train

  def initialize(number, type = :cargo)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
  end

  def valid_wagon?(wagon)
    wagon.type == type
  end
end
