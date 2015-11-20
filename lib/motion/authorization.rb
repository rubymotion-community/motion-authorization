module Motion
  class Authorization

    class << self
      attr_accessor :current_user

      def current_user_method(&block)
        @current_user_block = block
      end

      def current_user
        if @current_user_block
          @current_user_block.call
        else
          @current_user
        end
      end

      def can?(action, object)
        policy_class_name = "#{object.class}Policy"

        unless Object.const_defined?(policy_class_name)
          puts "Undefined permissions policy class #{policy_class_name}"
          return false
        end

        policy = policy_class_name.constantize.new(current_user, object)

        unless policy.respond_to?("#{action}?")
          puts "No #{action}? method found in #{policy_class_name}"
          return false
        end

        policy.send "#{action}?"
      end
    end

    module Methods
      def can?(action, object)           Motion::Authorization.can?(action, object) end
      def permitted_to?(action, object)  Motion::Authorization.can?(action, object) end
      def authorized_to?(action, object) Motion::Authorization.can?(action, object) end
      def authorised_to?(action, object) Motion::Authorization.can?(action, object) end
    end
  end
end
