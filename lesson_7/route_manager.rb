module RouteManager

  private

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
end
