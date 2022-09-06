//
//  TabBarViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/12.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabbar()
        self.navigationController?.addCustomBottomLine(color: UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0), height: 1.0)
    }
    

    
}


extension UINavigationController {
    func naviagation() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

extension UITabBarController {
    func tabbar() {
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = CGColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        tabBar.clipsToBounds = true
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = 90 // 원하는 길이
    return sizeThatFits
   }
}

extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")
    
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)
    
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}

extension UINavigationBar
{
    func bottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        self.setValue(true, forKey: "hidesShadow")
    
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

