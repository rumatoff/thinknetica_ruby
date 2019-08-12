# frozen_string_literal: true

class Wagon
  include Manufacturer
  include Validation
  extend Accessors

  attr_reader :type, :number

  def initialize(number, type)
    @number = number
    @type = type
  end
end
