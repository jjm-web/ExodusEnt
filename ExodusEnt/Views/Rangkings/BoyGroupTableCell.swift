//
//  BoyGroupTableCell.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/21.
//

import UIKit

class BoyGroupTableCell: UITableViewCell {
    
    @IBOutlet var medalImg: UIImageView!
    @IBOutlet var idolImg: UIImageView!
    
    @IBOutlet var lblBoyGroup: UILabel!
    @IBOutlet var lblAgency: UILabel!
    @IBOutlet var lblLanking: UILabel!
    @IBOutlet var lblPoint: UILabel!
    
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
