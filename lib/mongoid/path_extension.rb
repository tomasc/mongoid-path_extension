require 'mongoid'

module Mongoid
  class PathExtension < String
    delegate(:permalink, to: :parent, prefix: true)

    def initialize(str)
      super str.to_s
      @str = str.to_s
    end

    def components
      return [] unless @str.present?
      @str.split('/')
    end

    def root
      components.first
    end

    def permalink
      components.last
    end

    def permalink=(value)
      return if value.blank?
      new_str = [parent.to_s, value].join('/')
      @str.replace(new_str)
    end

    def absolute
      ['/', @str].join
    end

    def has_parent?
      parent.present?
    end

    def parent
      ancestors.last
    end
    alias_method :parent_path, :parent

    def ancestors
      components[0..-2].each_with_index.map do |component, index|
        Mongoid::PathExtension.new(components[0..index].join('/'))
      end
    end
    alias_method :ancestor_paths, :ancestors

    class << self
      def demongoize(value)
        PathExtension.new(value)
      end

      def mongoize(value)
        case value
        when PathExtension then value.mongoize
        else value
        end
      end

      def evolve(value)
        case value
        when PathExtension then value.mongoize
        else value
        end
      end
    end
  end
end
