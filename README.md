# spaceteam_timer
[![Build Status](https://travis-ci.org/palfrey/spaceteam-timer.svg?branch=master)](https://travis-ci.org/palfrey/spaceteam-timer)
[![Get it on Google Play](https://developer.android.com/images/brand/en_generic_rgb_wo_45.png)](https://play.google.com/store/apps/details?id=net.tevp.spaceteamtimer)

Deeply unofficial Spaceteam card game timer app

## Icon setup

If you change the icon (see assets/icon/icon.png) then re-run `flutter packages pub run flutter_launcher_icons:main` to get the new ios/android icons.

## Android release

To make a new Android release, create a file called `key.properties` in `android` with the following content (replacing all the "my" items as per https://flutter.io/docs/deployment/android#reference-the-keystore-from-the-app)

```
storePassword=myStorePassword
keyPassword=mykeyPassword
keyAlias=myKeyAlias
storeFile=myStoreFileLocation
```

Run `flutter build apk --release` to generate the file in `build/app/outputs/apk/release/app-release.apk`