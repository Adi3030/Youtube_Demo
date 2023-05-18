//
//  HeaderCollViewCell.swift
//  Youtube
//
//  Created by aditya sharma on 17/05/23.
//

import UIKit

class HeaderCollViewCell: UICollectionViewCell {

    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!    
    @IBOutlet weak var compassImg: UIImageView!
    @IBOutlet weak var containerLeading: NSLayoutConstraint!
    @IBOutlet weak var containerTrailing: NSLayoutConstraint!
    override class func awakeFromNib() {
        
    }
}
