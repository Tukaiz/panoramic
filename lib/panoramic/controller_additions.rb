module Panoramic

  module ControllerAdditions
    module ClassMethods

      def register_resolver_details
        panoramic_resource_class.add_before_filter(self, :register_resolver_details)
      end

      def panoramic_resource_class
        if ancestors.map(&:to_s).include? "InheritedResources::Actions"
          InheritedResource
        else
            ControllerResource
        end
      end

    end

    def self.included(base)
      base.extend ClassMethods
    end

  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Panoramic::ControllerAdditions
  end
end
