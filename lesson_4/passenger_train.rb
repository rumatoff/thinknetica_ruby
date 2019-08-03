class PassengerTrain < Train

  def valid_wagon?(wagon)
    wagon.type == type
  end
end
