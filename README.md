
## 高仿橘子娱乐项目 （不断完善更新中）
### [简书地址](https://www.jianshu.com/p/20ce1dfa84c5) 

## 简介

#### 使用OC语言高仿橘子娱乐APP，主要使用AsyncDisplayKit提升整个APP项目流畅性，保证主要界面FPS>60以上，由于练习使用ReactiveCocoa，后续会对项目内用的绑定相关进行修改。

## 目前完成的功能
- 视频广告启动页面
- 首页、视频、社区的布局
- 首页、视频feed流（资讯、快讯、GIF等）
- 资讯详情页（包括资讯内容、用户评论）
- 视频详情页（视频播放、资讯内容、用户评论）
- 社区tab内推荐、最新、发现的feed流
- feed流的下拉刷新

## 使用的三方库
- Texture（AsyncDisplayKit）主要流界面的布局
- MJRefresh下拉刷新实现
- XHLaunchAd视频、图片开屏的实现
- lottie-ios 一些json动画的实现
- Masonry 非node布局的实现
- AFNetworking 网络请求
- YYModel 模型解析
- YYWebImage 非node网络图片加载
- ReactiveCocoa 链式响应 （练习使用）

## 主要界面的GIF图
### 开屏
![博客_开屏.gif](http://upload-images.jianshu.io/upload_images/1770896-c9dd8cd86685dc16.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### feed流
![博客_首页feed流.gif](http://upload-images.jianshu.io/upload_images/1770896-38c9bebf50492c43.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![博客_gifFeed流.gif](http://upload-images.jianshu.io/upload_images/1770896-589327f94363c6b5.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 详情页
![微博_资讯详情.gif](http://upload-images.jianshu.io/upload_images/1770896-3ac5c176b3173e3b.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![博客_视频detail.gif](http://upload-images.jianshu.io/upload_images/1770896-61ff3d3973a930d6.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 社区
![博客_社区.gif](http://upload-images.jianshu.io/upload_images/1770896-8e7e99546478eff8.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 写在最后
该项目是在工作之余，用来练习使用一些新的三方库和架构模式练习写的。笔者在工作闲暇会坚持更新项目和博客，项目开始于2017.12月初，因为写的时间不是很长可能会存在一些bug和问题，我会对于这些问题及时修复。如果该项目对您有帮助，请在git上star一下，有问题也可以issue我，欢迎大家交流。