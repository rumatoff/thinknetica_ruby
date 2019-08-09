# frozen_string_literal: true

module RouteManager
  private

  def add_route_train
    puts 'Созданные станции: '
    station_list

    train = take_train
    route = add_route

    train.add_route(route)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def add_waypoint
    raise 'Создайте хотя бы 3 станции!' if @stations.count < 3
    raise 'Создайте хотя бы 1 поезд!' if @trains.empty?

    train = take_train
    station = take_station
    train.route.add_station(station)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def remove_waypoint
    train = take_train
    station = take_station
    train.route.delete_station(station)
  rescue StandardError => e
    puts e.message
    train_menu
  end

  def add_route
    raise 'Создайте хотя бы 2 станции!' if @stations.count < 2
    raise 'Создайте хотя бы 1 поезд!' if @trains.empty?

    print 'Введите имя начальной станции: '
    first = gets.chomp

    print 'Введите имя конечной станции: '
    last = gets.chomp

    first_station = select_station(first)
    last_station = select_station(last)

    Route.new(first_station, last_station)
  end
end
