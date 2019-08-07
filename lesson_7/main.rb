require_relative 'dependences'

class Main
  include StationManager

  attr_reader :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def main_menu
    puts '1. Управление станциями'
    puts '2. Управление поездами и маршрутами'
    puts '3. Выход'
    print 'Ваш выбор: '
    input = gets.chomp.to_i

    case input
    when 1
      station_menu
    when 2
      train_menu
    when 3
      abort
    else
      puts 'Не корректный ввод'
      print system('reset')
      main_menu
    end
  end

  private

  def station_menu
    station_menu_list
    input = gets.chomp.to_i

    case input
    when 1
      create_station
      station_menu
    when 2
      del_station
      station_menu
    when 3
      station_list
      station_menu
    when 4
      trains_list
      station_menu
    when 0
      main_menu
    else
      input_error
      station_menu
    end
  end

  def station_menu_list
    puts '1. Создание станции'
    puts '2. Удаление станции'
    puts '3. Просмотр списка станций'
    puts '4. Просмотр списка поездов на станции'
    puts 'Основное меню: 0'
    print 'Ваш выбор: '
  end

  def train_menu
    train_menu_list
    input = gets.chomp.to_i

    case input
    when 1
      print 'Введите номер пасажирского поезда: '
      number = gets.chomp
      create_train(number, :passenger)
      train_menu
    when 2
      print 'Введите номер грузового поезда: '
      number = gets.chomp
      create_train(number, :cargo)
      train_menu
    when 3
      add_new_wagon
      train_menu
    when 4
      del_wagon
      train_menu
    when 5
      if @stations.count < 2
        puts 'Создайте хотя бы 2 станции'
        station_menu
      elsif @trains.empty?
        puts 'Создайте хотя бы 1 поезд'
        train_menu
      else
        add_route_train
        train_menu
      end
    when 6
      if @stations.count < 3
        puts 'Создайте хотя бы 3 станции'
        station_menu
      elsif @trains.empty?
        puts 'Создайте хотя бы 1 поезд'
        train_menu
      else
        add_waypoint
        train_menu
      end
    when 7
      remove_waypoint
      train_menu
    when 8
      forward_train
      train_menu
    when 9
      backward_train
      train_menu
    # TODO Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
    # TODO Выводить список поездов на станции (в указанном выше формате), используя  созданные методы
    # TODO Занимать место или объем в вагоне
    when 0
      main_menu
    else
      input_error
      train_menu
    end
  end

  def train_menu_list
    puts '1. Создание пасажирского поезда'
    puts '2. Создание грузового поезда'
    puts '3. Добавить вагон к поезду'
    puts '4. Отцепить вагон от поезда'
    puts '5. Добавить маршрут'
    puts '6. Добавить точку к маршруту'
    puts '7. Удалить точку маршрута'
    puts '8. Переместить поезд по маршруту веперд'
    puts '9. Переместить поезд по маршруту назад'
    puts 'Основное меню: 0'
    print 'Ваш выбор: '
  end

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
    print 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    train = select_train(train_number)
    train.remove_wagon(wagon_number)
    puts "Вагон успешно отцеплен от поезда #{train.number}, общее количество вагонов #{train.wagons.size}"
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def forward_train
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)
    train.forward
  end

  def backward_train
    print 'Введите номер поезда: '
    number = gets.chomp
    train = select_train(number)
    train.backward
  end

  def add_route_train
    print 'Введите номер поезда: '
    number = gets.chomp

    puts 'Созданные станции: '
    station_list

    print 'Введите имя начальной станции: '
    first = gets.chomp

    print 'Введите имя конечной станции: '
    last = gets.chomp

    train = select_train(number)
    first_station = select_station(first)
    last_station = select_station(last)
    route = Route.new(first_station, last_station)
    train.add_route(route)
  end

  def add_waypoint
    print 'Введите номер поезда: '
    number = gets.chomp
    print 'Введите точку маршрута (станция): '
    station_name = gets.chomp
    station = select_station(station_name)
    train = select_train(number)
    train.route.add_station(station)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def remove_waypoint
    print 'Введите номер поезда: '
    number = gets.chomp
    print 'Введите точку маршрута которую необходимо удалить (станция): '
    station_name = gets.chomp
    station = select_station(station_name)
    train = select_train(number)
    train.route.delete_station(station)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def input_error
    puts 'Не корректный ввод'
    print system('reset')
  end
end
