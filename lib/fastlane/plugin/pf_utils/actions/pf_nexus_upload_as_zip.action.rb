require 'fastlane/action'

module Fastlane
  module Actions
    class PfNexusUploadAsZipAction < Action
      def self.run(params)
        if params[:as_zip]
          artifact_extension = File.extname(params[:artifact]).shellescape[1..-1]
          outputFilePath = "#{params[:artifact]}.zip"
          sh("zip -r #{outputFilePath} #{params[:artifact]}")
          classifier = params[:repo_classifier] ? "#{params[:repo_classifier]}-#{artifact_extension}" : artifact_extension

          other_action.nexus_upload(
            nexus_version: params[:nexus_version],
            mount_path: params[:mount_path],
            file: outputFilePath,
            repo_id: params[:repo_id],
            repo_group_id: params[:repo_group_id],
            repo_project_name: params[:repo_group_id],
            repo_project_version: params[:repo_project_version],
            repo_classifier: classifier,
            endpoint: params[:endpoint],
            username: params[:username],
            password: params[:password],
            verbose: params[:verbose]
          )
        else
          other_action.nexus_upload(
            nexus_version: params[:nexus_version],
            mount_path: params[:mount_path],
            file: params[:artifact],
            repo_id: params[:repo_id],
            repo_group_id: params[:repo_group_id],
            repo_project_name: params[:repo_project_name],
            repo_project_version: params[:repo_project_version],
            repo_classifier: params[:repo_classifier],
            endpoint: params[:endpoint],
            username: params[:username],
            password: params[:password],
            verbose: params[:verbose]
          )
        end
      end

      def self.description
        "Uploads artifact as zip to Nexus repository"
      end

      def self.authors
        ["Plataforma SDM"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :artifact,
                                       description: "Path to the artifact to upload",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :nexus_version,
                                       description: "Nexus Version",
                                       is_string: false
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_project_version,
                                       description: "Repo project version",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :repo_classifier,
                                       description: "Repo classifier for the artifact",
                                       optional: true,
                                       default_value: nil),
          FastlaneCore::ConfigItem.new(key: :as_zip,
                                       description: "Flag to indicate if artifact should be zipped before upload",
                                       optional: true,
                                       is_string: false,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :nexus_version,
                                       description: "Nexus version",
                                       optional: true,
                                       default_value: 3),
          FastlaneCore::ConfigItem.new(key: :mount_path,
                                       description: "Mount path",
                                       optional: true,
                                       default_value: ''),
          FastlaneCore::ConfigItem.new(key: :repo_id,
                                       description: "Repository ID",
                                       optional: true,
                                       default_value: 'mobile'),
          FastlaneCore::ConfigItem.new(key: :repo_group_id,
                                       description: "Repository group ID",
                                       optional: true,
                                       default_value: 'com.mapfre'),
          FastlaneCore::ConfigItem.new(key: :repo_project_name,
                                       description: "Repository project name",
                                       optional: true,
                                       default_value: 'mapfreapp'),
          FastlaneCore::ConfigItem.new(key: :endpoint,
                                       description: "Nexus endpoint URL",
                                       optional: true,
                                       default_value: ENV['NEXUS_URL']),
          FastlaneCore::ConfigItem.new(key: :username,
                                       description: "Nexus username",
                                       optional: true,
                                       default_value: ENV['NEXUS_USER']),
          FastlaneCore::ConfigItem.new(key: :password,
                                       description: "Nexus password",
                                       optional: true,
                                       default_value: ENV['NEXUS_PASSWORD']),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "Verbose output",
                                       optional: true,
                                       is_string: false,
                                       default_value: true)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end