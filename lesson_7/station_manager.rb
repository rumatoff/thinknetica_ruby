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
    station = take_station
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

  def station_train
    train_by_station
  rescue StandardError => e
    puts e.message
    station_menu
  end

  def train_by_station
    raise 'Станций пока нет' if stations.empty?
    raise 'Поездов пока нет' if trains.empty?

    stations.each do |station|
      puts "На станции #{station.name} следующие поезда: "
      station.each_train do |train|
        print "Поезд номер: #{train.number}, "
        print "Тип поезда: #{train.type}, "
        puts "Количество вагонов: #{train.wagons.count}."
      end
    end
  end

  def take_station
    print 'Введите имя станции: '
    name = gets.chomp.to_s
    select_station(name)
  end
end
