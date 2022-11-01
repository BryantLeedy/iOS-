//
//  QRTabBar.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/11.
//

import Foundation
import UIKit

protocol QRTabBarDelegate {
    func addButtonClickCall()
}

class QRTabBar: UITabBar {
    
    var qrDelegate : QRTabBarDelegate?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonW:CGFloat = self.frame.size.width / 5
        let buttonH:CGFloat = self.frame.size.height
        let buttonY:CGFloat = 0
        // 按钮索引
        var buttonIndex:Int = 0;
        for (_,sub) in self.subviews.enumerated() {
            
            if sub.self.isKind(of: NSClassFromString("UITabBarButton")!) {
                // 设置frame
                var buttonX:CGFloat = CGFloat(buttonIndex) * buttonW
                if buttonIndex >= 2 { // 右边的2个UITabBarButton
                    buttonX += buttonW
                }
                sub.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
                // 增加索引
                buttonIndex += 1
            }
        }
        //设置中间的发布按钮的frame
        addButton.frame = CGRect(x: 0, y: 0, width: buttonW, height: buttonH)
        addButton.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5)
    }
    
    // MARK: - 懒加载
    private lazy var addButton: UIButton = {
        () -> UIButton
        in
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "addButton"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "addButton"), for: UIControl.State.highlighted)
        // 2.监听按钮点击
        btn.addTarget(self, action:#selector(addButtonClick), for: UIControl.Event.touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    //点击事件
    @objc private func addButtonClick(){
        if (qrDelegate != nil) {
            qrDelegate?.addButtonClickCall()
        }
    }

    
}
