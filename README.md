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
- PROJECT -> Build Settings -> Base SDK に OSX10.7 or 10.8(自分のOSバージョン)
- Archtectures に 64bit
- TARGET -> SocketRocketOSX も同様にBaseSDK 10.7，64bit
![textream01](http://m-server.appspot.com/download/20130722230715.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEY4eslDA)
- 左上のターゲットをSocketRockeにしてビルド
![textream02](http://m-server.appspot.com/download/20130722232042.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEYmYMmDA)
- textream-clientに戻してビルド

なんか表示されたらOK
