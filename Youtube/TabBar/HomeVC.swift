//
//  HomeVC.swift
//  Youtube
//
//  Created by aditya sharma on 17/05/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}

extension HomeVC: UITableViewDelegate {

}

extension HomeVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return Constants.videoImgArr.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let shortsCell = tableView.dequeueReusableCell(withIdentifier: "ShortsTableViewCell", for: indexPath) as! ShortsTableViewCell
            return shortsCell
        } else {
            let videoCell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
            videoCell.viewImgView.image = UIImage(named: Constants.videoImgArr[indexPath.row])
            videoCell.profileImgView.image = UIImage(named: Constants.profileIconArr[indexPath.row])
            videoCell.viewsLbl.text = Constants.viewArr[indexPath.row]
            videoCell.timeStampLbl.text = Constants.timeStampArr[indexPath.row]
            videoCell.topicLbl.text = Constants.titleArr[indexPath.row]
            return videoCell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC

        vc.topic = Constants.titleArr[indexPath.row]
        vc.imgData = Constants.videoImgArr[indexPath.row]
        vc.views = Constants.viewArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
extension HomeVC: UICollectionViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270
        } else {
            return 300
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10   
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollViewCell", for: indexPath) as! HeaderCollViewCell
//        headerCell.headerContainerView.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/220, alpha: 1)

        if indexPath.row == 0 {
            headerCell.compassImg.isHidden = false
            headerCell.titleLbl.text = ""
            headerCell.containerLeading.constant = 20
            headerCell.containerTrailing.constant = 20
        } else {
            headerCell.containerLeading.constant =  0
            headerCell.containerTrailing.constant = 0
            headerCell.compassImg.isHidden = true
            headerCell.titleLbl.text = Constants.headerArr[indexPath.row]
        }
        return headerCell
    }


}
