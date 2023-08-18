//
//  BoySoloTableCell.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/21.
//

import UIKit

class BoySoloTableCell: UITableViewCell {

    @IBOutlet var medalImg: UIImageView!
    @IBOutlet var idolImg: UIImageView!
    @IBOutlet var lblBoySolo: UILabel!
    @IBOutlet var lblGroupName: UILabel!
    @IBOutlet var lblLanking: UILabel!
    
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
