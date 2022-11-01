//
//  ViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let tab = UITabBarController()

        let vc1 = JumpToOtherPagesViewController()
        let vc2 = ProvinceViewController()
        let vc3 = ScrollViewViewController()

        
        let nvc1 = UINavigationController(rootViewController: vc1)
        let nvc2 = UINavigationController(rootViewController: vc2)
        let nvc3 = UINavigationController(rootViewController: vc3)

        
        let tbItem1 = UITabBarItem(title: "首页CollectionView", image: UIImage(named: "imae.png"), selectedImage: nil)
        tbItem1.badgeColor = .black
        let tbItem2 = UITabBarItem(title: "省份列表", image: nil, selectedImage: nil)
        tbItem2.badgeColor = .black
        let tbItem3 = UITabBarItem(title: "ScrollView", image: nil, selectedImage: nil)
        tbItem3.badgeColor = .black
        
        tab.addChild(nvc1)
        tab.addChild(nvc2)
        tab.addChild(nvc3)
        
        nvc1.tabBarItem = tbItem1
        nvc2.tabBarItem = tbItem2
        nvc3.tabBarItem = tbItem3
        
        self.addChild(tab)
        self.view.addSubview(tab.view)
    }
}

