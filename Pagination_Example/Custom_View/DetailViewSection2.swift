//
//  DetailViewSection2.swift
//  Pagination_Example
//
//  Created by EkambaramE on 19/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class DetailViewSection2: UITableViewCell {

    @IBOutlet weak var grabButton: UIButton!
    @IBOutlet weak var offerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Corner cashBackButton button
        grabButton.layer.cornerRadius = grabButton.frame.size.width / 10
        grabButton.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
