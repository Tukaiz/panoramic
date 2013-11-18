module Panoramic
  class ControllerResource
    def self.add_before_filter(controller_class, method, *args)
      options = args.extract_options!
      resource_name = args.first
      before_filter_method = options.
        delete(:prepend) ? :prepend_before_filter : :before_filter
      controller_class.send(
        before_filter_method, options.
        slice(:only, :except, :if, :unless)) do |controller|
          controller.class.panoramic_resource_class.
            new(controller, resource_name,
                options.except(:only, :except, :if, :unless)).send(method)
        end
    end

    def initialize(controller, *args)
      @controller = controller
      @params = controller.params
      @options = args.extract_options!
      @name = args.first
    end

    def register_resolver_details
      @controller.lookup_context.class.register_detail(:site) { nil }
      # @controller.lookup_context.class.register_detail(:db_lookup) { false }
    end
  end
end
