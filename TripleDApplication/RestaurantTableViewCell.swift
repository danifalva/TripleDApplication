//
//  RestaurantTableViewCell.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/20/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
