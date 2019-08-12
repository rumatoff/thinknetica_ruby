# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(*args)
      @validations ||= []
      @validations << args
    end
  end

  module InstanceMethods
    def validate!
      var = self.class.validations
      var.each do |validation|
        send(validation[1], instance_variable_get("@#{validation[0]}"), validation[2])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(var, *)
      raise 'Аргумент пустой или nil' if var.to_s.empty?
    end

    def type(var, type)
      puts var.class
      puts type
      raise 'Не соответсвие типа' unless var.is_a? type
    end

    def format(var, exp)
      raise 'Не сотвествие шаблону' if var !~ exp
    end
  end
end
