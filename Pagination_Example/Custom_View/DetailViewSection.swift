//
//  DetailViewSection.swift
//  Pagination_Example
//
//  Created by EkambaramE on 18/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class DetailViewSection: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arealabel: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //round titleImageView label
        titleImageView.layer.cornerRadius = titleImageView.frame.size.width / 2
        titleImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 

}
