require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class PfAndroidMatchKeystoreHelper
      # class methods that you define here become available in your action
      # as `Helper::PfSAndroidMatchKeystoreHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pf_android_match_keystore plugin helper!")
      end
    end
  end
end
