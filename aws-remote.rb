# Casks/mdreader.rb
cask "mdreader" do
  version "1.0.0"
  sha256 "<sha256 of MDReader.zip>"

  url "https://github.com/ronenniv/md-reader/releases/download/v#{version}/MDReader.zip"
  name "MDReader"
  desc "Native macOS markdown reader/editor"
  homepage "https://github.com/ronenniv/md-reader"

  app "MDReader.app"

  postflight do
    system_command "/usr/bin/swift",
                   args: ["#{staged_path}/scripts/set-default-handler.swift",
                          "/Applications/MDReader.app"],
                   must_succeed: false
  end
end
