require 'fastlane/action'
require_relative '../helper/pf_copy_artifact_and_rename_helper'

module Fastlane
  module Actions
    class PfCopyAndRenameArtifactsAction < Action
      def self.run(options)
        require 'fastlane/actions/shared_values' # Add this require statement

        gradle(project_dir: 'android', task: options[:task], build_type: options[:build_type], flavor: options[:flavor] || nil)
        artifact_path = options[:build_type] == 'Debug' ? lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH] : lane_context[SharedValues::GRADLE_AAB_OUTPUT_PATH]
        default_dir_relative_to_workspace = 'dist/artifacts/mets'

        if options[:app_name]
          target_path = options[:dist_artifacts_path] || "../../../#{default_dir_relative_to_workspace}"
          artifact_extension = File.extname(artifact_path).shellescape
          new_artifact_name = "#{options[:app_name]}-#{get_app_version}#{artifact_extension}"
          sh("mkdir -p #{target_path}")
          sh("cp \"#{artifact_path}\" \"#{target_path}/#{new_artifact_name}\"")
        else
          target_path = options[:dist_artifacts_path] || "../../#{default_dir_relative_to_workspace}"
          copy_artifacts(target_path: target_path, artifacts: [artifact_path])
        end
      end

      def self.description
        "Copy and rename artifacts android"
      end

      def self.authors
        ["Your Name"]
      end

      def self.available_options
        require 'fastlane_core/config_item' # Add this require statement

        [
          FastlaneCore::ConfigItem.new(key: :app_name,
                                       description: "Name of the app",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :dist_artifacts_path,
                                       description: "Path to the destination directory for artifacts",
                                       optional: true)
          # Add other options as needed
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
