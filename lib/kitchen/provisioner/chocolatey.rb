# -*- encoding: utf-8 -*-
#
# Author:: Steven Murawski (<steven.murawski@gmail.com>)
#
# Copyright (C) 2018 Steven Murawski
#
# Licensed under the Apache 2 License.
# See LICENSE for more details

require "fileutils"
require "pathname"
require "kitchen/provisioner/base"
require "kitchen/util"

module Kitchen
  module Provisioner
    class Chocolatey < Base
      kitchen_provisioner_api_version 2

      attr_accessor :tmp_dir

      default_config :packages_path
      default_config :package_name, ''
      default_config :package_parameters

      def install_command
        install_chocolatey = <<-EOH
        if (-not (get-command choco -ea silentlycontinue)) {
          iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        EOH

        wrap_powershell_code(install_chocolatey)
      end

      def init_command
        wrap_powershell_code('choco feature enable -n allowGlobalConfirmation')
      end

      def create_sandbox
        super
        info("Staging Chocolatey Packages for copy to the SUT")

        return unless config[:packages_path]

        info("Preparing packages")
        debug("Using packages from #{config[:packages_path]}")

        tmpdata_dir = File.join(sandbox_path, "packages")
        FileUtils.mkdir_p(tmpdata_dir)
        FileUtils.cp_r(Util.list_directory(config[:packages_path]), tmpdata_dir)
      end

      def prepare_command

      end

      def run_command
        command = "choco install #{config[:package_name]} -df "
        if config[:package_parameters]
          command += " --params='#{config[:package_parameters]}' "
        end
        if config[:packages_path]
          command += " -s #{config[:root_path]} "
        end
        info("Running: '#{command}'")
        wrap_powershell_code(command)
      end

      private

      def wrap_powershell_code(code)
        wrap_shell_code(["$ProgressPreference = 'SilentlyContinue';", code].join("\n"))
      end
    end
  end
end
