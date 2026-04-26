cask "nepali-calendar" do
  version "1.3.1"
  # The sha256 and version are rewritten in-place by scripts/publish.sh after
  # each build. Do not hand-edit unless you know what you're doing.
  sha256 "9905c70126e901a5d4416613a3b1db094d28290646992cc6b36637d9d9a9a3c1"

  url "https://github.com/sauravcghimire/nepali-calendar/releases/download/v#{version}/NepaliCalendar.zip"
  name "Nepali Calendar"
  desc "Menu-bar app showing today's Nepali (BS) date, events, and rashifal"
  homepage "https://github.com/sauravcghimire/nepali-calendar"

  depends_on macos: ">= :ventura"

  app "NepaliCalendar.app"

  # Launch the app immediately after install so the user sees the menu-bar
  # pill appear — no extra steps needed on their end. On first launch the
  # app also registers itself as a login item (via SMAppService), so it will
  # come back automatically whenever the Mac is rebooted or a new user
  # session starts. Both behaviours are user-toggleable from the popover
  # footer and from System Settings → General → Login Items.
  postflight do
    # Clear the "downloaded from internet" quarantine flag so Gatekeeper
    # doesn't block the ad-hoc-signed binary on first launch. Homebrew has
    # already verified the SHA256 of the download, so this is safe in the
    # cask context. Standard pattern for unsigned / ad-hoc-signed casks.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NepaliCalendar.app"],
                   sudo: false
    system_command "/usr/bin/open",
                   args: ["-a", "#{appdir}/NepaliCalendar.app"]
  end

  uninstall_preflight do
    system_command "/usr/bin/pkill",
                   args: ["-x", "NepaliCalendar"],
                   sudo: false,
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Preferences/com.saurav.nepalicalendar.plist",
    "~/Library/Saved Application State/com.saurav.nepalicalendar.savedState",
  ]
end
