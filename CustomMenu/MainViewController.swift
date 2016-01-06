//
//  MainViewController.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 25.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var gradientLayer: CAGradientLayer!
    
    // create instance of our custom transition
    let menuTransition = MenuAnimatedTransitioning()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.menuTransition.sourceViewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let menu = segue.destinationViewController as! MenuViewController
        menu.transitioningDelegate = self.menuTransition
        
        self.menuTransition.menuViewController = menu
    }
    
    override func viewDidLayoutSubviews() {
        setupGradient()
    }
    
    func setupGradient() {
        self.gradientLayer = CAGradientLayer()
        
        let half = view.layer.bounds.height / 2
        let frame = CGRect(x: 0, y: view.layer.bounds.height - half, width: view.layer.bounds.width, height: half)
        
        self.gradientLayer.frame = frame
        gradientLayer.opacity = 0.5
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 2)

        self.gradientLayer.colors = [UIColor.clearColor().CGColor,  UIColor.blackColor().CGColor]
        view.layer.insertSublayer(self.gradientLayer, atIndex: 1)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MainTableViewCell
        
        cell.cellImageView.image = UIImage(named: "\(indexPath.row)")
        
        return cell
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let visibleCells = tableView.visibleCells as? [MainTableViewCell] {
            for parallaxCell in visibleCells {
                let yOffset = ((tableView.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }
}

