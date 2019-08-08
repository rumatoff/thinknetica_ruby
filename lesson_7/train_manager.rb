module TrainManager

  private

  def trains_list
    print 'Введите имя станции: '
    name = gets.chomp.to_s
    station = select_station(name)
    if station.trains.empty?
      puts "На станции #{station.name} нет поездов."
    else
      station.trains.each { |train| puts "Поезд номер: #{train.number}" }
    end
  end

  def create_train(number, type)
    type == :passenger ? train = PassengerTrain.new(number, type) : train = CargoTrain.new(number, type)
    trains << train
    puts "Поезд номер #{number} успешно создан"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def select_train(number)
    raise 'Номер поезда не может быть пустым' if number.empty? || number.nil?

    train = trains.find { |train| train.number == number }
    if train.nil?
      raise 'Поезд с таким номером не найден'
    else
      train
    end
  end

  def forward_train
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)
    train.forward
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def backward_train
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)
    train.backward
  rescue StandardError => e
    puts e.message
    train_menu
  end
end
