//
//  MenuViewController.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 25.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var cameraLabel: UILabel!
    
    @IBOutlet var compassImageView: UIImageView!
    @IBOutlet var compassLabel: UILabel!
    
    @IBOutlet var markerImageView: UIImageView!
    @IBOutlet var markerLabel: UILabel!
    
    @IBOutlet var plannerImageView: UIImageView!
    @IBOutlet var plannerLabel: UILabel!
    
    @IBOutlet var routeImageView: UIImageView!
    @IBOutlet var routeLabel: UILabel!
    
    @IBOutlet var suitcaseImageView: UIImageView!
    @IBOutlet var suitcaseLabel: UILabel!
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
