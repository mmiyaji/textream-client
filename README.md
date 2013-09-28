textream-client
===============
![textream0](http://m-server.appspot.com/download/Screen%20Shot%202013-09-28%20at%209.47.50%20PM.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEY4egmDA)
ニコニコ動画みたいにユーザのコメントをデスクトップ上に流すソフトです。（Mac専用）
サーバとはWebsocketで接続しており、ブラウザから入力したコメントをリアルタイムで表示することができます。
知人の結婚式二次会用に作成しました。
動画とか流している上で参加者からのコメントを流したりして盛り上げようという寸法ですね。

Download app
-------
[textream ver1.1](http://m-server.appspot.com/download/textream.app.zip?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEY8bkmDA)

How to use
--------
1. サーバアプリのインストール( [textream](https://github.com/mmiyaji/textream) ).
2. クライアントアプリを起動してサーバURLをセット.
![textream01](http://m-server.appspot.com/download/20130928213210.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEYwckmDA)
3. サーバにブラウザでアクセス http://localhost:3000 .
4. 適当につぶやく.
![textream02](http://m-server.appspot.com/download/Screen%20Shot%202013-09-28%20at%209.36.53%20PM.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEYkdkmDA)


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
![textream03](http://m-server.appspot.com/download/20130722230715.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEY4eslDA)
- 左上のターゲットをSocketRockeにしてビルド
![textream04](http://m-server.appspot.com/download/20130722232042.png?fid=aghtLXNlcnZlcnIQCxIIUG9zdERhdGEYmYMmDA)
- textream-clientに戻してビルド

なんか表示されたらOK
