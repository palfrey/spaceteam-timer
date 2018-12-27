# Spaceteam timer
[![Build Status](https://travis-ci.org/palfrey/spaceteam-timer.svg?branch=master)](https://travis-ci.org/palfrey/spaceteam-timer)
[![Get it on Google Play](https://developer.android.com/images/brand/en_generic_rgb_wo_45.png)](https://play.google.com/store/apps/details?id=net.tevp.spaceteamtimer)

Deeply unofficial Spaceteam card game timer app

## Development

For the most part, this is a very standard [Flutter](https://flutter.io/) app and all of the standard info in those docs should get you most of the way there.

## Icon setup

If you change the icon (see [assets/icon/icon.png](assets/icon/icon.png)) then re-run `flutter packages pub run flutter_launcher_icons:main` to get the new iOS/Android icons.

## Android release

To make a new Android release, create a file called `key.properties` in [android](android) with the following content (replacing all the "my" items as per https://flutter.io/docs/deployment/android#reference-the-keystore-from-the-app)

```
storePassword=myStorePassword
keyPassword=mykeyPassword
keyAlias=myKeyAlias
storeFile=myStoreFileLocation
```

Run `flutter build apk --release` to generate the file in `build/app/outputs/apk/release/app-release.apk`

## iOS release

TBD. [The Travis builds](https://travis-ci.org/palfrey/spaceteam-timer) check that iOS at least builds, but a lack of an iOS device and my unwillingness to give Apple another $99/year means I haven't tried this out yet.