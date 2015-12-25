//
//  MenuViewController.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 25.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBAction func closeButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
