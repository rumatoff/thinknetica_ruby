class CargoTrain < Train

  def valid_wagon?(wagon)
    wagon.class == CargoWagon
  end
end
