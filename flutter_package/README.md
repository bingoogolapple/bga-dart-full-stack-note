# flutter_package

A new Flutter package.

[![Pub](https://img.shields.io/pub/v/bga_flutter_package.svg)](https://pub.dev/packages/bga_flutter_package)
[![Support](https://img.shields.io/badge/Platform-Flutter%7CFlutter%20Web%7CDart%20VM-aa69b4.svg)](https://github.com/bingoogolapple/flutter-note)

## 发布 package 到公共 pub

* 预发布，看是否满足发布条件，「-n」表示「--dry-run」
```
pub publish -n -v
```
* 正真发布，会生成「~/.pub-cache/credentials.json」证书文件。一定要加 sudo，否则会报错。发布时需要 google 账户认证，会访问 accounts.google.com，所以需要配置科学上网
```
sudo pub publish -v
```

## [发布 package 到 pub 私服](https://github.com/dart-lang/pub_server)

* 初始化并启动 pub_server，文件存储在「~/.pub-cache/hosted/pub_server」目录下
```
# 初始化 pub_server
git clone https://github.com/dart-lang/pub_server.git && cd pub_server && pub get
# 创建存储目录
mkdir -p ~/.pub-cache/hosted/pub_server
# 启动 pub_server
dart example/example.dart -d ~/.pub-cache/hosted/pub_server
```
* 到项目中发布 package，要先配置 PUB_HOSTED_URL 环境变量
```
# 配置环境变量
export PUB_HOSTED_URL=http://localhost:8080
# 预发布，看是否满足发布条件
pub publish -n -v
# 真正发布
pub publish -v
```
* 发布完后会在「~/.pub-cache/hosted/pub_server」目录生成相应库的文件
![image](https://user-images.githubusercontent.com/8949716/67954211-806e0d00-fc2b-11e9-88f9-ffe3ce6570b7.png)
* pub_server 没有图形管理界面，发布和使用时都不需要账号认证