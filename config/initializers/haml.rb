module Haml
  module Filters
    # This is an extension of Sass::Rails's SassTemplate class that allows
    # Rails's asset helpers to be used inside Haml Sass filter.
    class SassRailsTemplate
      def render(scope=Object.new, locals={}, &block)
        scope = ::Rails.application.assets.context_class.new({environment: ::Rails.application.assets, logical_path: "/", filename: "/", metadata: {}})
        super
      end
    end
  end
end
