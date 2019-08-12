# frozen_string_literal: true

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
    raise 'Первую или последную удалить нельзя!' unless can_delete?(station)

    stations.delete(station)
  end

  private

  def validate!
    raise 'Объект не сототвествует типу' unless stations_type_valid?
  end

  def stations_type_valid?
    stations.first.is_a?(Station) && stations.last.is_a?(Station)
  end

  def can_delete?(station)
    station != stations.first && station != stations.last
  end
end
