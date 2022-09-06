//
//  MainBannerViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/19.
//

import UIKit

class MainBannerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var mainBannerCollection: UICollectionView!
    
   
    
    let mainImageArray: Array<UIImage> = [UIImage(named: "benner_1.jpeg")!, UIImage(named: "benner_2.jpeg")!, UIImage(named: "benner_3.jpeg")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBannerCollection.delegate = self
        mainBannerCollection.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainImageArray.count // Replace with count of your data for collectionViewA
            
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = mainBannerCollection.dequeueReusableCell(withReuseIdentifier: "MainBannerCell", for: indexPath) as! MainBannerCell
        cell.mainImg.image = mainImageArray[indexPath.row]
        cell.mainImg.layer.borderWidth = 1
        cell.mainImg.layer.cornerRadius = 16
        cell.mainImg.layer.masksToBounds = true
        
        return cell
                          
    }

}

