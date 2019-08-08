module RouteManager

  private

  def add_route_train
    train = take_train

    puts 'Созданные станции: '
    station_list

    print 'Введите имя начальной станции: '
    first = gets.chomp

    print 'Введите имя конечной станции: '
    last = gets.chomp

    first_station = select_station(first)
    last_station = select_station(last)
    route = Route.new(first_station, last_station)
    train.add_route(route)
  end

  def add_waypoint
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
end
