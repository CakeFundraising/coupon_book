module Templatable
  extend ActiveSupport::Concern

  module ClassMethods
    def has_templates(*templates)
      opts = { column_name: :template }.merge templates.extract_options!
      (self.templates ||= {})[opts[:column_name]] = templates

      self.templates[opts[:column_name]].each do |template|
        scope template, -> { where opts[:column_name] => template }
        define_method(:"#{template}_template?") { self.send(opts[:column_name]).to_s.to_sym == template }
      end
    end
  end

  included do
    class_attribute :templates
  end
end