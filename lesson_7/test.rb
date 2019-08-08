require_relative 'dependences'

train = PassengerTrain.new('12345')
wagon_number = '1'.to_i
seat_init = '10'.to_i
wagon = PassengerWagon.new(wagon_number, seat_init)
train.add_wagon(wagon)