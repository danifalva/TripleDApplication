//
//  NearMeTableViewCell.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/27/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import UIKit

class NearMeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nearNameLabel: UILabel!
    @IBOutlet weak var nearDescripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
