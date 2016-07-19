//
//  ViewControllerCell.swift
//  Pagination_Example
//
//  Created by EkambaramE on 18/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class ViewControllerCell: UITableViewCell {
    
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var cashBackButton: UIButton!
    
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var offerView: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    
        //Corner cashBackButton button
        cashBackButton.layer.cornerRadius = cashBackButton.frame.size.width / 8
        cashBackButton.clipsToBounds = true
        
        //round titleImageView label
        titleImageView.layer.cornerRadius = titleImageView.frame.size.width / 2
        titleImageView.clipsToBounds = true
        
        //Corner avalilability label
        availabilityLabel.layer.cornerRadius = availabilityLabel.frame.size.width / 8
        availabilityLabel.clipsToBounds = true
        availabilityLabel.textColor = UIColor.whiteColor()
        
        //Number of lines for offer label
        offerLabel.numberOfLines = 2
        
        //Distance border
        distanceView.layer.borderColor = UIColor.lightGrayColor().CGColor
        distanceView.layer.borderWidth = 1.0
        
        //Offer View
        offerView.layer.borderColor = UIColor.greenColor().CGColor
        offerView.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
