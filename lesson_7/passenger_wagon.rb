class PassengerWagon < Wagon

  attr_reader :seat_free, :number

  def initialize(number, seat_init, type = :passenger)
    @number = number
    @type = type
    @seat_init, @seat_free = seat_init
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
    raise 'Номер вагона не соотвествует заданному формату' unless @number.is_a?(Integer) && @number.positive?
    raise 'Количество мест не соотвествует заданному формату' unless @seat_init.is_a?(Integer) && @seat_init.positive?
  end
end
