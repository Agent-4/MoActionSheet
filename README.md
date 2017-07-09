# MoActionSheet
底部弹出视图，类似于微信、微博的底部弹出视图。
##### 效果图：

<img src="https://github.com/Agent-4/MoActionSheet/blob/master/ScreenShot.png" width="240"> 

##### 用法：

```
// example 1

MoActionSheet.show(withTitle: "更换头像", destructiveTitle: nil, otherTitles: ["拍照","从相册选择"]) { (index) in
    print("点击了：\(index)")
}

```

