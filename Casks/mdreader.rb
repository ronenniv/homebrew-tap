cask "mdreader" do
  version "1.0.1"
  sha256 "7e79a99a08065bdaf31695568e74002852e42310941023592cd50af3c9bd198e"

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
    system_command "/usr/bin/swift",
                   args: [
                     "#{appdir}/MDReader.app/Contents/Resources/set-default-handler.swift",
                     "#{appdir}/MDReader.app",
                   ],
                   must_succeed: false
  end

  caveats <<~EOS
    Releases are currently ad-hoc signed. Install with:
      brew install --cask --no-quarantine mdreader
    or approve the app via right-click -> Open on first launch.
  EOS
end
