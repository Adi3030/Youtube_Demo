//
//  CommonsVideoCell.swift
//  Youtube
//
//  Created by aditya sharma on 22/05/23.
//

import UIKit

class CommonsVideoCell: UITableViewCell {

    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var viewImgView: UIImageView!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
