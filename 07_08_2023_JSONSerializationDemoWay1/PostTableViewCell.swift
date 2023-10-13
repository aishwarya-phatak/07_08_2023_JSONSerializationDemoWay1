//
//  PostTableViewCell.swift
//  07_08_2023_JSONSerializationDemoWay1
//
//  Created by Vishal Jagtap on 13/10/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postUserId: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
