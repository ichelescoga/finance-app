# developer_company

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## change name and bundle ID
```
  flutter pub global activate rename
  flutter pub global run rename --appname "Finance Flow & Marketing"
  flutter pub global run rename --bundleId com.financeApp.FinanceFlow&Marketing
  flutter pub global run rename --bundleId com.financeApp.FinanceFlowMarketing
```

## generate APK

For some reason the compressed package generated for flutter (flutter build apk) doesn't work, so please use the command below.
```
flutter build apk --debug
```
this generate a app-debug.apk more weightily but works fine.



## Pull Files from android to PC

```
adb pull /storage/emulated/0/Download/$nameOfFile C:\Users\elpab\Downloads
```


## ICONS
[Icons Inspiration](https://icons8.com/icon/set/no-image/cotton)


## PERMISSIONS IOS 

video_player
https://docs.flutter.dev/cookbook/plugins/play-video

<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>