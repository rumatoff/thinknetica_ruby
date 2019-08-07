class Route
  include InstanceCounter

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) if station != stations.first && station != stations.last
  end

  def validate!
    raise 'Объект не сототвествует типу' unless (stations.first.is_a? Station) || (stations.last.is_a? Station)
  end
end
