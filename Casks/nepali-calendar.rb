cask "nepali-calendar" do
  version "1.0.0"
  # The sha256 and version are rewritten in-place by scripts/publish.sh after
  # each build. Do not hand-edit unless you know what you're doing.
  sha256 "18906326eb6098df81b879942b7f6d3157d96a28c95c2a443f7a5a37437b5c4a"

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
    system_command "/usr/bin/open",
                   args: ["-a", "#{appdir}/NepaliCalendar.app"]
  end

  uninstall_postflight do
    # Stop any running instance so the login-item unregistration can take
    # effect cleanly before the .app is removed.
    system_command "/usr/bin/pkill",
                   args: ["-x", "NepaliCalendar"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.saurav.nepalicalendar.plist",
    "~/Library/Saved Application State/com.saurav.nepalicalendar.savedState",
  ]
end
