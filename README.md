# flutter_note

A new Flutter application.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).


# react-note

```
npm install -g yarn
npm install -g create-react-app
create-react-app react-note && cd react-note
yarn start
```

```
npm install --save react-router-dom axios less@^2.7.3 less-loader
npm run eject

yarn add react-router-dom axios less@^2.7.3 less-loader
yarn eject
```


```
拷贝 .css，改为 .less，最后追加

{
loader:require.resolve('less-loader'),
options: {
  modules: false,
  modifyVars: {
      "@primary-color": "#f9c700"
  }
}
}
```

```
npm install --save antd
npm install --save-dev babel-plugin-import

yarn add antd
yarn add babel-plugin-import --dev

```
```
test: /\.(js|jsx|mjs)$/, 中增加下面的代码块，style 为 true 表示动态编译

options: {
      plugins:[
        ['import',[{
          libraryName:'antd',
          style:true
        }]]
      ],
      compact: true,
    },
```