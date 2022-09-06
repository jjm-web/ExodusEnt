//
//  GroupBoyViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/21.
//

import UIKit

class GroupBoyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_3: UITableView!
    
    var groupNameArray = [ "방탄소년단", "엔하이픈", "엔시티", "세븐틴", "스트레이키즈", "투모로우바이투게더", "위너", "SF9", "GOT7", "트레저"]
    
    var groupImgArray  = ["bts.jpeg", "enhypen.jpeg","nct.jpeg","seventeen.jpeg", "starykids.jpeg","txt.jpeg","winner.jpeg","sf9.jpeg","got7.jpeg", "treasure.jpeg"]
    
    var medalArray = ["gold.svg","silver.svg","bronze.svg","","","","","","",""]
    var lankingArray = ["1","2","3","4","5","6","7","8","9","10"]
    var pointArray = ["1,000","900","800","700","600","500","400","300","200","100"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_3.delegate = self
        table_3.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return groupNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table_3.dequeueReusableCell(withIdentifier: "BoyGroupTableCell") as! BoyGroupTableCell
      
        cell.lblGroupName.text = groupNameArray[indexPath.row]
        cell.lblLanking.text = lankingArray[indexPath.row]
        cell.medalImg.image = UIImage(named: medalArray[indexPath.row])
        cell.idolImg.image = UIImage(named: groupImgArray[indexPath.row])
        cell.separatorInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        cell.heartButton.setImage(UIImage(contentsOfFile: "heart.svg"), for: .normal)
        cell.imgHeart.image = UIImage(named: "heart_fill.svg")
        cell.idolImg.layer.cornerRadius = 8
        cell.lblPoint.text = pointArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    
    
}
