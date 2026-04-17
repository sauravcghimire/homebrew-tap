# homebrew-tap

A personal Homebrew tap that publishes the **Nepali Calendar** macOS menu-bar app.

## How end users install

```bash
brew tap sauravcghimire/tap
brew install --cask nepali-calendar
```

After `brew install`, launch it once from `/Applications/NepaliCalendar.app` (or
via Spotlight). From then on the status bar icon appears automatically on login
(enable "Open at Login" manually in System Settings if desired).

## How to publish a new version

1. Bump `APP_VERSION` and run the build from the project root:

   ```bash
   APP_VERSION=0.2.0 ./scripts/build-app.sh
   ```

2. Create a GitHub Release in the `nepali-calendar` repo tagged `v0.2.0` and
   upload `build/NepaliCalendar.zip` as a release asset.

3. Copy the SHA256 from `build/NepaliCalendar.zip.sha256` and update
   `Casks/nepali-calendar.rb`:

   - `version "0.2.0"`
   - `sha256 "<new sha>"`
   - confirm the `url` still matches the uploaded asset

4. Commit and push this tap repo. Users can then run:

   ```bash
   brew update
   brew upgrade --cask nepali-calendar
   ```

## How to publish this tap for the first time

A Homebrew tap is just a public GitHub repo named `homebrew-<anything>`.

1. Create a public repo on GitHub named `homebrew-tap` (e.g.
   `github.com/sauravcghimire/homebrew-tap`).
2. Push the contents of this folder to that repo.
3. Share the install command shown at the top of this README.

No submission to `homebrew/cask` is required; personal taps work independently.
