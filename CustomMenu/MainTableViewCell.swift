//
//  MainTableViewCell.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 25.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

let ImageHeight: CGFloat = 250.0
let OffsetSpeed: CGFloat = 25.0

class MainTableViewCell: UITableViewCell {
    @IBOutlet var cellImageView: UIImageView!
    
    func offset(offset: CGPoint) {
        cellImageView.frame = CGRectOffset(self.cellImageView.bounds, offset.x, offset.y)
    }
}
