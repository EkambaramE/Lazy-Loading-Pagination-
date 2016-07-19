//
//  DetailviewSection3.swift
//  Pagination_Example
//
//  Created by EkambaramE on 19/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class DetailviewSection3: UITableViewCell {
    
    @IBOutlet weak var redeemButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        redeemButton.layer.cornerRadius = redeemButton.frame.size.width / 8
        redeemButton.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
