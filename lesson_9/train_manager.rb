# frozen_string_literal: true

module TrainManager
  private

  def trains_list
    station = take_station
    raise "На станции #{station.name} нет поездов." if station.trains.empty?

    station.trains.each { |train| puts "Поезд номер: #{train.number}" }
  rescue StandardError => e
    puts e.message
    station_menu
  end

  def create_passenger_train
    print 'Введите номер пасажирского поезда: '
    number = gets.chomp
    train = PassengerTrain.new(number)
    trains << train
    puts "Пассажирский поезд номер #{number} успешно создан"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def create_cargo_train
    print 'Введите номер грузового поезда: '
    number = gets.chomp
    train = CargoTrain.new(number)
    trains << train
    puts "Грузовой поезд номер #{number} успешно создан"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def select_train(number)
    raise 'Номер поезда не может быть пустым' if number.empty? || number.nil?

    train = trains.find { |created_train| created_train.number == number }
    raise 'Поезд с таким номером не найден' if train.nil?

    train
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
    puts "Поезд номер #{train.number},
          тип: #{train.class},  количество вагонов: #{train.wagons.count}"
    if train.type == :passenger
      passenger_train_wagons(train)
    else
      cargo_train_wagons(train)
    end
  end

  def passenger_train_wagons(train)
    train.each_wagon do |wagon|
      print "Вагон номер: #{wagon.number}, "
      print "всего мест: #{wagon.seat_init}, "
      print "свободных мест: #{wagon.seat_free}, "
      puts "занятых мест: #{wagon.occupied_seats}."
    end
  end

  def cargo_train_wagons(train)
    train.each_wagon do |wagon|
      print "Вагон номер: #{wagon.number}, "
      print "полный объем: #{wagon.volume_init}, "
      print "свободный объем: #{wagon.free_volume}, "
      puts "занятый объем: #{wagon.occupied_volume}."
    end
  end

  def take_train
    print 'Введите номер поезда: '
    number = gets.chomp
    select_train(number)
  end
end
