//
//  MoActionSheet.swift
//  MoActionSheet
//
//  Created by moxiaohao on 2017/7/1.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class MoActionSheet: UIView {
    
    typealias MoActionSheetBlock = (_ index: Int) -> Void
    
    weak var contentView: UIView?
    fileprivate var title: String?
    fileprivate var destructiveTitle: String?
    fileprivate var otherTitles: Array<Any>!
    fileprivate var blurBackground: UIVisualEffectView?
    fileprivate var block: MoActionSheetBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(TapGestureAction))
        addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func TapGestureAction(_ tap: UITapGestureRecognizer) {
        if tap.location(in: tap.view).y < frame.size.height - (contentView?.frame.size.height)! {
            dismiss()
        }
    }
    
    class func show(withTitle title: String?, destructiveTitle: String?, otherTitles: [Any]?, block: @escaping MoActionSheetBlock) {
        UIApplication.shared.keyWindow?.endEditing(true)
        let sheet = MoActionSheet()
        let window = UIApplication.shared.keyWindow
        sheet.frame = (window?.bounds)!
        sheet.title = title
        sheet.destructiveTitle = destructiveTitle
        sheet.otherTitles = otherTitles
        sheet.block = block
        sheet.show()
        window?.addSubview(sheet)
    }
    
    // 显示
    func show() {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.clear
        self.contentView = contentView
        // 设置模糊背景
        blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurBackground?.frame = self.frame
        contentView.addSubview(blurBackground!)
        
        var y: CGFloat = 0
        var tag: Int = 0
        
        if title != nil {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13)
            titleLabel.textColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.tag = tag
            
            let size = title?.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 2*20, height: CGFloat(MAXFLOAT)),
                                           options: .usesLineFragmentOrigin,
                                           attributes: [NSFontAttributeName: titleLabel.font],
                                           context: nil).size
            titleLabel.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.size.width - 2*20, height: (size?.height)!)
            
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: (size?.height)! + 2*20)
            contentView.addSubview(view)
            contentView.addSubview(titleLabel)
            y = (size?.height)! + 2 * 20 + 1.0/UIScreen.main.scale
        }
        
        if otherTitles != nil {
            for i in 0 ..< otherTitles.count {
                let button = createButton(withTitle: otherTitles[i] as! String, color: UIColor.black, font: UIFont.systemFont(ofSize: 16), height: 46, y: y + (46 + 1.0/UIScreen.main.scale) * CGFloat(i))
                contentView.addSubview(button)
                if i == otherTitles.count - 1 {
                    y = y + (46 + 1.0/UIScreen.main.scale) * CGFloat(i) + 46
                }
                button.tag = tag
                tag += 1
            }
        }
        
        if destructiveTitle != nil {
            let button = createButton(withTitle: destructiveTitle!, color: UIColor.red, font: UIFont.systemFont(ofSize: 16), height: 46, y: y + 1.0/UIScreen.main.scale)
            button.tag = tag
            contentView.addSubview(button)
            y += (46 + 5)
            tag += 1
        }else {
            y += 5
        }
        
        let cancel = createButton(withTitle: "取消", color: UIColor.black, font: UIFont.systemFont(ofSize: 16), height: 45, y: y)
        cancel.tag = tag
        contentView.addSubview(cancel)
        
        let maxY = contentView.subviews.last?.frame.maxY
        contentView.frame = CGRect(x: 0, y: self.frame.size.height - maxY!, width: UIScreen.main.bounds.size.width, height: maxY!)
        self.addSubview(contentView)
        
        let frame = contentView.frame
        var newframe = frame
        newframe.origin.y = self.frame.size.height
        contentView.frame = newframe
        
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0.3)
            contentView.frame = frame
        }, completion: nil)
    }
    
    // 创建按钮
    func createButton(withTitle title: String, color: UIColor, font: UIFont, height: CGFloat, y: CGFloat) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setBackgroundImage(imageWithColor(color: UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 0.25)), for: .highlighted)
        button.titleLabel?.font = font
        button.titleLabel?.textAlignment = .center
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.size.width, height: height)
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        return button
    }
    
    // 点击
    func clickAction(_ button: UIButton) {
        if (block != nil) {
            block!(Int(button.tag))
        }
        dismiss()
    }
    
    // 取消
    func dismiss() {
        var frame: CGRect = contentView!.frame
        frame.origin.y += frame.size.height
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            self.backgroundColor = UIColor.clear
            self.contentView?.frame = frame
        }, completion: {(_ finished: Bool) -> Void in
            self.removeFromSuperview()
        })
    }
    
    // 纯颜色图片
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.addRect(CGRect(x: 0, y: 0, width: 1, height: 1))
        color.set()
        context?.fillPath()
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

