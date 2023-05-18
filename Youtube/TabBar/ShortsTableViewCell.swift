//
//  ShortsTableViewCell.swift
//  Youtube
//
//  Created by aditya sharma on 17/05/23.
//

import UIKit

class ShortsTableViewCell: UITableViewCell {

    @IBOutlet weak var shortsCollView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        shortsCollView.delegate = self
        shortsCollView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ShortsTableViewCell: UICollectionViewDelegate { }


extension ShortsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shortsCell = shortsCollView.dequeueReusableCell(withReuseIdentifier: "ShortsCollViewCell", for: indexPath) as! ShortsCollViewCell
        shortsCell.shortsImgView.image = UIImage(named: Constants.shortsArr[indexPath.row])
        return shortsCell
    }


}
