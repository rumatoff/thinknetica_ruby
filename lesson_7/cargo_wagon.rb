class CargoWagon < Wagon

  attr_reader :free_volume, :volume_init, :number

  def initialize(number, volume_init, type = :cargo)
    @number = number
    @type = type
    @volume_init = volume_init
    @free_volume = volume_init
    valid!
  end

  def fill_volume(volume)
    raise 'Нет такого количества объема' if volume > @free_volume

    @free_volume -= volume
  end

  def occupied_volume
    @volume_init - @free_volume
  end

  private

  def valid!
    raise 'Номер вагона не соотвествует заданному формату' unless @number.is_a?(Integer) && @number.positive?
    raise 'Количество объема не соотвествует заданному формату' unless @volume_init.is_a?(Float) && @volume_init.positive?
  end
end
