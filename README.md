# MoActionSheet

![Swift3](https://img.shields.io/badge/Swift-3.0-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/Agent-4/MoActionSheet/blob/master/LICENSE)

底部弹出视图，类似于微信、微博的底部弹出视图。
##### 效果图：

![example 1](https://github.com/Agent-4/MoActionSheet/blob/master/ScreenShot.png)
![example 2](https://github.com/Agent-4/MoActionSheet/blob/master/ScreenShot2.png)

##### 用法：

```
// example 1

MoActionSheet.show(withTitle: "更换头像", destructiveTitle: nil, otherTitles: ["拍照","从相册选择"]) { (index) in
    print("点击了：\(index)")
}


// example 2

MoActionSheet.show(withTitle: "确定要退出登录？", destructiveTitle: "退出登录", otherTitles: nil) { (index) in
    print("点击了：\(index)")
}

```

