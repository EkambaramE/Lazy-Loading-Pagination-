//
//  ProgressHUD.swift
//  Pagination_Example
//
//  Created by EkambaramE on 19/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

import UIKit

class ActivityIndicatorView {
    
    var loadingView = UIView()
    var container = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showLoading() {
        
        let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
        self.loadingView.frame = CGRectMake(win.frame.width/2 - (win.frame.width/5)/2, win.frame.height/2 - (win.frame.width/5)/2, win.frame.width/5, win.frame.width/5)
        self.loadingView.tag = 1
        self.loadingView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        win.addSubview(self.loadingView)
        
        activityIndicator.frame = CGRectMake(0, 0, win.frame.width/5, win.frame.width/5)
        activityIndicator.activityIndicatorViewStyle = .Gray
        
        self.loadingView.addSubview(container)
        self.loadingView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
    }
    
    func hideLoading(){
        UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: {
            self.container.alpha = 0.0
            self.loadingView.alpha = 0.0
            self.activityIndicator.stopAnimating()
            }, completion: { finished in
                self.activityIndicator.removeFromSuperview()
                self.container.removeFromSuperview()
                self.loadingView.removeFromSuperview()
                let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
                let removeView  = win.viewWithTag(1)
                removeView?.removeFromSuperview()
        })
    }
}