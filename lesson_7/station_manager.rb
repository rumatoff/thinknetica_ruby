module StationManager

  private

  def create_station
    print 'Введите имя станции: '
    name = gets.chomp.to_s
    station = Station.new(name)
    stations << station
    puts "Станция #{name} успешно создана"
  rescue StandardError => e
    puts e.message
    station_menu
  end

  def select_station(name)
    raise 'Имя станции не может быть пустым' if name.empty? || name.nil?

    station = stations.find { |station| station.name == name }
    if station.nil?
      raise 'Станция с таким именем не надйена'
    else
      station
    end
  end

  def del_station
    print 'Введите имя станции: '
    name = gets.chomp.to_s
    station = select_station(name)
    @stations.delete(station)
    puts "Станция #{name} успешно удалена"
  rescue StandardError => e
    puts e.message
    station_menu
  end

  def station_list
    if stations.empty?
      puts 'Станций пока нет'
    else
      stations.each { |station| puts station.name }
    end
  end
end