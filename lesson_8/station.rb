# frozen_string_literal: true

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def train_by_type(type)
    trains.select { |train| train.type == type }
  end

  def each_train
    trains.each { |train| yield(train) } if block_given?
  end

  private

  def validate!
    raise 'Имя не может быть пустым' if @name.empty? || @name.nil?
  end
end
