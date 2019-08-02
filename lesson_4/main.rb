require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
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
    puts '1. Создание станции'
    puts '2. Удаление станции'
    puts '3. Просмотр списка станций'
    puts '4. Просмотр списка поездов на станции'
    puts 'Основное меню: 0'
    print 'Ваш выбор: '
    input = gets.chomp.to_i

    case input
    when 1
      print 'Введите имя станции: '
      name = gets.chomp.to_s
      create_station(name)
      station_menu
    when 2
      print 'Введите имя станции: '
      name = gets.chomp.to_s
      del_station(name)
      station_menu
    when 3
      station_list
      station_menu
    when 4
      print 'Введите имя станции: '
      name = gets.chomp.to_s
      trains_list(name)
      station_menu
    when 0
      main_menu
    else
      puts 'Не корректный ввод'
      print system('reset')
      station_menu
    end
  end

  def create_station(name)
    station = Station.new(name)
    stations << station
    puts "Станция #{name} успешно создана"
  end

  def del_station(name)
    stations.each { |station| stations.delete(station) if station.name == name }
    puts "Станция #{name} успешно удалена"
  end

  def station_list
    if stations.empty?
      puts 'Станций пока нет'
    else
      stations.each { |station| puts station.name }
    end
  end

  def train_menu
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
    input = gets.chomp.to_i

    case input
    when 1
      print 'Введите номер пасажирского поезда: '
      number = gets.chomp.to_i
      create_train(number, :passenger)
      train_menu
    when 2
      print 'Введите номер грузового поезда: '
      number = gets.chomp.to_i
      create_train(number, :cargo)
      train_menu
    when 3
      print 'Введите номер поезда: '
      number = gets.chomp.to_i
      add_new_wagon(number)
      train_menu
    when 4
      print 'Введите номер поезда: '
      number = gets.chomp.to_i
      del_wagon(number)
      train_menu
    when 5
      if @stations.count < 2
        puts 'Создайте хотя бы 2 станции'
        station_menu
      elsif @trains.empty?
        puts 'Создайте хотя бы 1 поезд'
        train_menu
      else
        print 'Введите номер поезда: '
        number = gets.chomp.to_i
        puts 'Созданные станции: '
        station_list
        print 'Введите имя начальной станции: '
        first = gets.chomp
        print 'Введите имя конечной станции: '
        last = gets.chomp

        add_route_train(number, first, last)
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
        print 'Введите номер поезда: '
        number = gets.chomp.to_i
        print 'Введите точку маршрута (станция): '
        waypoint = gets.chomp
        add_waypoint(number, waypoint)
        train_menu
      end
    when 7
      print 'Введите номер поезда: '
      number = gets.chomp.to_i
      print 'Введите точку маршрута которую необходимо удалить (станция): '
      waypoint = gets.chomp
      remove_waypoint(number, waypoint)
      train_menu
    when 8
      print 'Введите номер поезда: '
      number = gets.chomp.to_i
      forward_train(number)
      train_menu
    when 9
      print 'Введите номер поезда: '
      number = gets.chomp.to_i
      backward_train(number)
      train_menu
    when 0
      main_menu
    else
      puts 'Не корректный ввод'
      print system('reset')
      train_menu
    end
  end

  def trains_list(name)
    station = stations.find { |station| station.name == name }
    if station.trains.empty?
      puts "На станции #{station.name} нет поездов."
    else
      station.trains.each { |train| puts "Поезд номер: #{train.number}" }
    end
  end

  def create_train(number, type)
    type == :passenger ? train = PassengerTrain.new(number) : train = CargoTrain.new(number)
    trains << train
    puts "Поезд номер #{number} успешно создан"
  end

  def select_train(number)
    trains.find{ |train| train.number == number }
  end

  def add_new_wagon(number)
    train = select_train(number)
    train.class == CargoTrain ? wagon = CargoWagon.new : wagon = PassengerWagon.new
    train.add_wagon(wagon)
    puts "Вагон успешно добавлен к поезду #{number}, общее количество вагонов #{train.wagons.size}"
  end

  def del_wagon(number)
    train = select_train(number)
    train.remove_wagon
    puts "Вагон успешно отцеплен от поезда #{number}, общее количество вагонов #{train.wagons.size}"
  end

  def forward_train(number)
    train = select_train(number)
    train.forward
  end

  def backward_train(number)
    train = select_train(number)
    train.backward
  end

  def add_route_train(number, first, last)
    train = select_train(number)

    first_station = select_station(first)
    last_station = select_station(last)

    route = Route.new(first_station, last_station)

    route.stations.each { |station| puts station[0].name }
    train.add_route(route)
  end

  def select_station(name)
    @stations.select { |station| station.name == name }
  end

  def add_waypoint(number, station)
    train = select_train(number)
    puts train.route.add_station(station)
  end

  def remove_waypoint(number, station)
    train = select_train(number)
    puts train.route.delete_station(station)
  end

end