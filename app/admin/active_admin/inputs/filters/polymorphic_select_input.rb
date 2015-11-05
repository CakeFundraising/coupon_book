module ActiveAdmin::Inputs::Filters
  class PolymorphicSelectInput < SelectInput
    def initialize(*args)
      name, options = args.slice(4, 2)

      @_poly_type  = name
      @_poly_assoc = options[:on] or raise(":polymorphic_select needs the polymorphic association name in the :on option")

      super
    end

    # MetaSearch syntax for polymorphic associations
    def input_name
      [@_poly_assoc, 'of', @_poly_type.to_s.camelize, 'type_id_eq'].join('_')
    end

  end
end