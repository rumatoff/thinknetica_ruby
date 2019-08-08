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
  rescue StandardError => e
    puts e.message
    station_menu
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
    train = take_train
    train.forward
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def backward_train
    train = take_train
    train.backward
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def train_wagons
    train = take_train
    puts "Поезд номер #{train.number}, тип: #{train.class},  количество вагонов: #{train.wagons.count}"
    if train.type == :passenger
      train.each_wagon do |wagon|
        print "Вагон номер: #{wagon.number}, "
        print "всего мест: #{wagon.seat_init}, "
        print "свободных мест: #{wagon.seat_free}, "
        puts "занятых мест: #{wagon.occupied_seats}."
      end
    else
      train.each_wagon do |wagon|
        print "Вагон номер: #{wagon.number}, "
        print "полный объем: #{wagon.volume_init}, "
        print "свободный объем: #{wagon.free_volume}, "
        puts "занятый объем: #{wagon.occupied_volume}."
      end
    end
  end

  def take_train
    print 'Введите номер поезда: '
    number = gets.chomp
    select_train(number)
  end
end
