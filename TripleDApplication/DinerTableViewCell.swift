//
//  DinerTableViewCell.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/25/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import UIKit

class DinerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dinerNameLabel: UILabel!    
    @IBOutlet weak var dinerDescripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
