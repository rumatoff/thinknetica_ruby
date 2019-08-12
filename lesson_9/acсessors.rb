# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var = "@#{name}_history".to_sym
      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history_var) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history = if instance_variable_defined?(history_var)
                    instance_variable_get(history_var)
                  else
                    instance_variable_set(history_var, [])
                  end
        history << value
      end
    end
  end

  def strong_attr_acessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name.to_sym) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise ArgumentError, 'Неверный тип класса' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
