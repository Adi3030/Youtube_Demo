//
//  DetailsVC.swift
//  Youtube
//
//  Created by aditya sharma on 18/05/23.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var lanLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    var responseData:VideosModel = VideosModel(videos: [])
    var imgData = ""
    var topic = ""
    var lan = ""
    var views = ""
    var timeStamp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        videoImg.image = UIImage(named: imgData)
        topicLbl.text = topic
        lanLbl.text = "Swift"
        viewsLbl.text = views

        let videoCellNib = UINib(nibName: "CommonsVideoCell", bundle: nil)
        tableView.register(videoCellNib, forCellReuseIdentifier: "CommonsVideoCell")
        NetworkManager.shared.getVideosData { videosData, errorMessage in
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

    @IBAction func shareBtn(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }

    @IBAction func likeUnlikeBtn(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            UserDefaults.standard.set(sender.isSelected, forKey: "isSaved")

        } else {
            sender.isSelected = true
            UserDefaults.standard.set(sender.isSelected, forKey: "isSaved")

        }
    }


}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData.videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonsVideoCell", for: indexPath) as! CommonsVideoCell
        cell.timeStampLbl.text = responseData.videos[indexPath.row].timeStamp
        cell.topicLbl.text = responseData.videos[indexPath.row].title
        cell.viewImgView.image = UIImage(named: responseData.videos[indexPath.row].thumbnail)
        cell.profileImgView.image = UIImage(named: responseData.videos[indexPath.row].profilePic)
        cell.viewsLbl.text = responseData.videos[indexPath.row].views
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
