//
//  TableCell.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/06.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet var idolImage: UIImageView!
    @IBOutlet var idolName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
