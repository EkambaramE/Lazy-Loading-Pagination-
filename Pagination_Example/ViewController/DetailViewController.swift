//
//  DetailViewController.swift
//  Pagination_Example
//
//  Created by EkambaramE on 19/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var detailTableView: UITableView!
    
    var detailFoodDrink = FoodDrinks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load custom tableview cell
        detailTableView.registerNib(UINib(nibName: "DetailViewSection", bundle: nil), forCellReuseIdentifier: "section")
        detailTableView.registerNib(UINib(nibName: "DetailViewSection2", bundle: nil), forCellReuseIdentifier: "section1")
        detailTableView.registerNib(UINib(nibName: "DetailviewSection3", bundle: nil), forCellReuseIdentifier: "section2")
        detailTableView.separatorColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return (detailFoodDrink.offers?.count)!
        } else if section == 2 {
            return 1
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell?
       
        if indexPath.section == 0 {
            let cell1: DetailViewSection  = tableView.dequeueReusableCellWithIdentifier("section") as! DetailViewSection
            cell1.bannerImageView.image = getImageDataFromURL(detailFoodDrink.heroImage!)!
            cell1.titleImageView.image = getImageDataFromURL(detailFoodDrink.logo!)!
            cell1.titleLabel.text = detailFoodDrink.name
            cell1.arealabel.text = detailFoodDrink.area
            cell1.timing.text = detailFoodDrink.timing
            cell1.address.text = detailFoodDrink.address
            
            for tags in detailFoodDrink.tags! {
                cell1.tags.text = cell1.tags.text! + tags
            }
            
            cell = cell1
            
        } else if indexPath.section == 1 {
            let cell2: DetailViewSection2 = tableView.dequeueReusableCellWithIdentifier("section1") as! DetailViewSection2
            cell2.offerLabel.text = detailFoodDrink.offers![indexPath.row].valueForKey("description") as? String
            cell = cell2
            
        }else {
            cell = tableView.dequeueReusableCellWithIdentifier("section2") as! DetailviewSection3
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let tableViewWidth = tableView.bounds
        
        let headerView = UIView(frame: CGRectMake(0, 5, tableViewWidth.size.width, tableView.sectionHeaderHeight + 20))
        headerView.backgroundColor = UIColor.lightGrayColor()
        
        let headerTitle = UILabel(frame: CGRect(x: 10, y: 5, width: tableViewWidth.size.width, height: tableView.sectionHeaderHeight - 10 ))
        headerTitle.textColor = UIColor.blackColor()
        
        if section == 1 {
            headerTitle.text = "DEALS"
            headerView.addSubview(headerTitle)
        } else if section == 2 {
            headerTitle.text = "LOYALTY STAMPS"
            headerView.addSubview(headerTitle)
        }
        
        return headerView
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var sectionHeaderheight: CGFloat = 0.0
        
        if section == 0 {
            sectionHeaderheight = 0
        } else {
            sectionHeaderheight = 30.0
        }
        return sectionHeaderheight
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 350.0
        } else if indexPath.section == 1 {
            return 58.0
        } else {
            return 206.0
        }
    }
    
    func getImageDataFromURL(url: String) -> UIImage? {
        
        var imageData:UIImage?
        
        dispatch_sync(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            imageData  =  UIImage(data: NSData(contentsOfURL: NSURL(string:url)!)!)
        })
        
        return imageData
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
