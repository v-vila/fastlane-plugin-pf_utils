require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class PfNexusUploadAsZipHelper
      # class methods that you define here become available in your action
      # as `Helper::PfNexusUploadAsZipHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pf_nexus_upload_aszip plugin helper!")
      end
    end
  end
end
