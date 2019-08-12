# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :seat_free, :seat_init, :number

  def initialize(number, seat_init, type = :passenger)
    @number = number
    @type = type
    @seat_init = seat_init
    @seat_free = seat_init
    valid!
  end

  def take_place
    raise 'Свободных мест нет' if @seat_free.zero?

    @seat_free -= 1
  end

  def occupied_seats
    @seat_init - @seat_free
  end

  private

  def valid!
    raise 'Номер не соотвествует заданному формату' unless input_valid?(@number)
    raise 'Количество мест не корректно' unless input_valid?(@seat_init)
  end

  def input_valid?(input)
    input.is_a?(Integer) && input.positive?
  end
end
