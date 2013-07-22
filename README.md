textream-client
===============


Install
-------

$ git clone https://github.com/mmiyaji/textream-client.git
$ cd textream-client
$ git submodule init
$ git submodule update
$ open textream-client.xcodeproj

@Xcode

- 左サイドバーの SocketRocket.xcodeproj を選択
- PROJECT -> Build Settiongs -> Base SDK に OSX10.7 or 10.8(自分のOSバージョン)
- Archtectures に 64bit
- TARGET -> SocketRocketOSX も同様にBaseSDK 10.7，64bit
- 左上のターゲットをSocketRockeにしてビルド
- textream-clientに戻してビルド

なんか表示されたらOK
