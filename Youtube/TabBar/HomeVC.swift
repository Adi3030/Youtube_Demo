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
    var responseData:VideosModel = VideosModel(videos: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        let videoCellNib = UINib(nibName: "CommonsVideoCell", bundle: nil)
        tableView.register(videoCellNib, forCellReuseIdentifier: "CommonsVideoCell")

        NetworkManager.shared.getVideosData{ videosData, errorMessage in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }

            guard let videos = videosData else {
                print("No data")
                return
            }

            self.responseData = videos
        }
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
            return responseData.videos.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let shortsCell = tableView.dequeueReusableCell(withIdentifier: "ShortsTableViewCell", for: indexPath) as! ShortsTableViewCell
            return shortsCell
        } else {
            let videoCell = tableView.dequeueReusableCell(withIdentifier: "CommonsVideoCell", for: indexPath) as! CommonsVideoCell
            videoCell.timeStampLbl.text = responseData.videos[indexPath.row].timeStamp
            videoCell.topicLbl.text = responseData.videos[indexPath.row].title
            videoCell.viewImgView.image = UIImage(named: responseData.videos[indexPath.row].thumbnail)
            videoCell.profileImgView.image = UIImage(named: responseData.videos[indexPath.row].profilePic)
            videoCell.viewsLbl.text = responseData.videos[indexPath.row].views
            return videoCell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC

        vc.topic = responseData.videos[indexPath.row].title
        vc.imgData = responseData.videos[indexPath.row].thumbnail
        vc.views = responseData.videos[indexPath.row].views
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
