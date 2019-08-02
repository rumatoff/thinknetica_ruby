require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
  t = Train.new('1')
  st1 = Station.new('Moscow')
  st2 = Station.new('Tver')
  r = Route.new(st1 ,st2)
  t.add_route(r)
end


