require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class PfSetAppEnvironmentHelper
      # class methods that you define here become available in your action
      # as `Helper::PfSetAppEnvironmentHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pf_set_app_environment plugin helper!")
      end
    end
  end
end
