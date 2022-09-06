//
//  NewsSegmented.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/16.
//


import Foundation
import UIKit

extension UISegmentedControl{
    func newsRemoveBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0), NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 12.0)! ] ,for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 12.0)!], for: .selected)
        
        self.layer.cornerRadius = 16.0
        self.layer.borderColor = CGColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        
    }

}



