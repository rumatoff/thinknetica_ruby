# frozen_string_literal: true

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
    raise 'Номер не корректен' unless input_valid?(@number, Integer)
    raise 'Объема не корректен' unless input_valid?(@volume_init)
  end

  def input_valid?(input, type = Float)
    input.is_a?(type) && input.positive?
  end
end
