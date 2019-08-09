# frozen_string_literal: true

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
    train = take_train
    wagon = train.type == :cargo ? create_cargo_wagon : create_passenger_wagon
    train.add_wagon(wagon)
    puts "Вагон успешно добавлен к поезду #{train.number},
          общее количество вагонов #{train.wagons.size}"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def del_wagon
    train = take_train
    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    train.remove_wagon(wagon_number)
    puts "Вагон #{wagon_number} успешно отцеплен от поезда #{train.number},
           общее количество вагонов #{train.wagons.size}"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def take_place
    train = take_train

    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i

    wagon = train.select_wagon(wagon_number)

    wagon.type == :passenger ? passenger_take_place(wagon) : cargo_take_volume(wagon)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def passenger_take_place(wagon)
    wagon.take_place
    puts 'Место занято'
  end

  def cargo_take_volume(wagon)
    print 'Введите количество занимаемого места: '
    volume = gets.chomp.to_f
    wagon.fill_volume(volume)
    puts 'Объем занят'
  end
end
