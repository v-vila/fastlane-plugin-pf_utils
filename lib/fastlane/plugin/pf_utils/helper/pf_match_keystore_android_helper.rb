require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class PfMatchKeystoreAndroidHelper
      # class methods that you define here become available in your action
      # as `Helper::MatchKeystoreAndroidHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pf_match_keystore_android plugin helper!")
      end
    end
  end
end
