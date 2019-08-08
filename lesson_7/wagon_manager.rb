module WagonManager

  private

  def create_cargo_wagon
    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    print 'Введите объем вагона: '
    init_volume = gets.chomp.to_f
    CargoWagon.new(wagon_number, init_volume)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def create_passenger_wagon
    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    print 'Введите количество свободных мест: '
    seat_init = gets.chomp.to_i
    PassengerWagon.new(wagon_number, seat_init)
  end

  def add_new_wagon
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)

    wagon = if train.type == :cargo
              create_cargo_wagon
            else
              create_passenger_wagon
            end
    train.add_wagon(wagon)
    puts "Вагон успешно добавлен к поезду #{number}, общее количество вагонов #{train.wagons.size}"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def del_wagon
    print 'Введите номер поезда: '
    train_number = gets.chomp
    train = select_train(train_number)
    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    train.remove_wagon(wagon_number)
    puts "Вагон успешно отцеплен от поезда #{train.number}, общее количество вагонов #{train.wagons.size}"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def take_place
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)

    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    wagon = train.select_wagon(wagon_number)

    if wagon.type == :passenger
      wagon.take_place
      puts 'Место занято'
    else
      print 'Введите количество занимаемого места: '
      volume = gets.chomp.to_f
      wagon.fill_volume(volume)
      puts 'Объем занят'
    end
  rescue StandardError => e
    puts e.message
    train_menu
  end
end
