//
//  ViewController.swift
//  Pagination_Example
//
//  Created by EkambaramE on 18/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var foodDrinks:Array<FoodDrinks>?
    var foodDrinksWrapper:FoodDrinksWrapper? // holds the last wrapper that we've loaded
    var isLoadingSpecies = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load custom tableview cell
        tableView.registerNib(UINib(nibName: "ViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.clearColor()
        
        //load initial pages
        self.loadFirstSpecies()
        
    }
    
    /**
     Configure initial pages
     */
    func loadFirstSpecies()
    {
        ActivityIndicatorView().showLoading()
        isLoadingSpecies = true
        FoodDrinks.getSpecies({ (foodDrinksWrapper, error) in
            if error != nil
            {
                // TODO: improved error handling
                self.isLoadingSpecies = false
                let alert = UIAlertController(title: "Error", message: "Could not load first species \(error?.localizedDescription)", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            //Adding to the main array
            self.addSpeciesFromWrapper(foodDrinksWrapper)
            self.isLoadingSpecies = false
            ActivityIndicatorView().hideLoading()
            self.tableView.reloadData()
        })
    }
    
    /**
     Load more pages
     */
    func loadMoreSpecies()
    {
        self.isLoadingSpecies = true
        ActivityIndicatorView().showLoading()
        if self.foodDrinks != nil && self.foodDrinksWrapper != nil && self.foodDrinks!.count < self.foodDrinksWrapper!.count
        {
            // there are more species out there!
            FoodDrinks.getMoreSpecies(self.foodDrinksWrapper, completionHandler: { (moreWrapper, error) in
                if error != nil
                {
                    // TODO: improved error handling
                    self.isLoadingSpecies = false
                    let alert = UIAlertController(title: "Error", message: "Could not load more species \(error?.localizedDescription)", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                self.addSpeciesFromWrapper(moreWrapper)
                self.isLoadingSpecies = false
                ActivityIndicatorView().hideLoading()
                self.tableView?.reloadData()
            })
        }
    }
    
    /**
     Adding recent pages into existing array
     
     - parameter wrapper: wrapper description
     */
    func addSpeciesFromWrapper(wrapper: FoodDrinksWrapper?)
    {
        self.foodDrinksWrapper = wrapper
        
        if self.foodDrinks == nil
        {
            self.foodDrinks = self.foodDrinksWrapper?.foodDrinks
        }
        else if self.foodDrinksWrapper != nil && self.foodDrinksWrapper!.foodDrinks != nil
        {
            self.foodDrinks = self.foodDrinks! + self.foodDrinksWrapper!.foodDrinks!
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:  UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ViewControllerCell
         cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if self.foodDrinks != nil && self.foodDrinks!.count >= indexPath.row
        {
            let foodDrink = self.foodDrinks![indexPath.row]
            
            let distanceValue = Float(foodDrink.distanceFromUser!)
            
            cell.placeLabel.text = foodDrink.area
            cell.distanceLabel.text = String(format: "%.2f", distanceValue!)
            
             cell.titleImageView.sd_setImageWithURL(NSURL(string: foodDrink.logo!))
             cell.bannerImageView.sd_setImageWithURL(NSURL(string: foodDrink.heroImage!))
            
            cell.titleLabel.text = foodDrink.name
            
            if foodDrink.offers!.count > 0 {
                cell.offerLabel.text = foodDrink.offers![0].valueForKey("description") as? String
            }
            
            // See if we need to load more pages
            let rowsToLoadFromBottom = 5;
            let rowsLoaded = self.foodDrinks!.count
            
            if (!self.isLoadingSpecies && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom)))
            {
                var totalRows = 0
                
                if (self.foodDrinksWrapper != nil) {
                    totalRows = self.foodDrinksWrapper!.count!
                } else {
                    totalRows = 140
                }
                
                let remainingSpeciesToLoad = totalRows - rowsLoaded;
                
                if (remainingSpeciesToLoad > 0)
                {
                    self.loadMoreSpecies()
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.foodDrinks == nil
        {
            return 0
        }
        return self.foodDrinks!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detail_segue", sender: indexPath)
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 330.0
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier!.isEqual("detail_segue") {
            
            let index = sender as! NSIndexPath
            let detail : DetailViewController = segue.destinationViewController as! DetailViewController
            detail.detailFoodDrink = foodDrinks![(index.row)]
        }
    }
}

