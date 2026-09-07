cask "mdreader" do
  version "1.0.2"
  sha256 "e4510a13db0b9eba7c9b643a923b9ddcc44a79998898a933e72137c1c3e78e85"

  url "https://github.com/ronenniv/md-reader/releases/download/v#{version}/MDReader.zip"
  name "MDReader"
  desc "Native macOS markdown reader/editor"
  homepage "https://github.com/ronenniv/md-reader"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "MDReader.app"

  # Make MDReader the default app for .md files (script is embedded in the
  # app bundle; /usr/bin/swift is present because Homebrew requires CLT).
  postflight do
    # Strip quarantine: releases are ad-hoc signed until notarization, and a
    # quarantined launch cannot load the app's resources. Remove this stanza
    # once releases are notarized.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MDReader.app"],
                   must_succeed: false
    system_command "/usr/bin/swift",
                   args: [
                     "#{appdir}/MDReader.app/Contents/Resources/set-default-handler.swift",
                     "#{appdir}/MDReader.app",
                   ],
                   must_succeed: false
  end

  caveats <<~EOS
    Releases are ad-hoc signed until notarization; install/upgrade removes
    the quarantine flag automatically. If macOS ever re-quarantines the app
    (it will show a recovery dialog), run:
      xattr -dr com.apple.quarantine /Applications/MDReader.app
  EOS
end
