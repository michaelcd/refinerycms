unless defined? ::Rails
  require 'rails'
  require 'action_controller/railtie'
end
require File.expand_path('../base/refinery', __FILE__)
require File.expand_path('../generators/refinerycms_base_generator', __FILE__)

module Refinery

  module Base
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < ::Rails::Engine
      isolate_namespace ::Refinery

      config.autoload_paths += %W( #{config.root}/lib )

      config.after_initialize do
        ::Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinerycms_base'
          plugin.class_name = 'RefineryBaseEngine'
          plugin.version = ::Refinery.version
          plugin.hide_from_menu = true
          plugin.always_allow_access = true
          plugin.menu_match = /refinery\/(refinery_base)$/
        end
      end
    end
  end

end

::Refinery.engines << 'base'
