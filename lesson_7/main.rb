require_relative 'dependences'

class Main
  include StationManager
  include TrainManager
  include WagonManager
  include RouteManager

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
    puts '10. Занять место или объем'
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
    when 10
      take_place
      train_menu
    # TODO Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
    # TODO Выводить список поездов на станции (в указанном выше формате), используя  созданные методы
    when 0
      main_menu
    else
      input_error
      train_menu
    end
  end

  def input_error
    puts 'Не корректный ввод'
    print system('reset')
  end
end
