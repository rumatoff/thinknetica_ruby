# frozen_string_literal: true

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

  MAIN_MENU = { '1': 'station_menu', '2': 'train_menu', '3': 'abort' }.freeze
  STATION_MENU = { '1': 'create_station', '2': 'del_station',
                   '3': 'station_list', '4': 'trains_list',
                   '5': 'station_train', '0': 'main_menu' }.freeze
  TRAIN_MENU = { '1': 'create_passenger_train', '2': 'create_cargo_train',
                 '3': 'add_new_wagon', '4': 'del_wagon',
                 '5': 'add_route_train', '6': 'add_waypoint',
                 '7': 'remove_waypoint', '8': 'forward_train',
                 '9': 'backward_train', '10': 'take_place',
                 '11': 'train_wagons', '0': 'main_menu' }.freeze

  def main_menu
    main_menu_text
    input = gets.chomp.to_sym

    select_main_menu = lambda do
      send MAIN_MENU[input]
      send main_menu
    end

    MAIN_MENU[input] ? select_main_menu.call : input_error
  end

  private

  def station_menu
    station_menu_text
    input = gets.chomp.to_sym

    select_station_menu = lambda do
      send STATION_MENU[input]
      send station_menu
    end

    STATION_MENU[input] ? select_station_menu.call : input_error
  end

  def train_menu
    train_menu_text
    input = gets.chomp.to_sym

    select_train_menu = lambda do
      send TRAIN_MENU[input]
      send train_menu
    end

    TRAIN_MENU[input] ? select_train_menu.call : input_error
  end

  def main_menu_text
    puts '1. Управление станциями'
    puts '2. Управление поездами и маршрутами'
    puts '3. Выход'
    print 'Ваш выбор: '
  end

  def station_menu_text
    puts '1. Создание станции'
    puts '2. Удаление станции'
    puts '3. Просмотр списка станций'
    puts '4. Просмотр списка поездов на станции'
    puts '5. Поезда на всех станциях'
    puts 'Основное меню: 0'
    print 'Ваш выбор: '
  end

  def train_menu_text
    @train_menu_text ||= File.read('train_menu.txt')
    puts @train_menu_text
    print 'Ваш выбор: '
  end

  def input_error
    system 'cls'
    puts 'Не корректный ввод'
    main_menu
  end
end
