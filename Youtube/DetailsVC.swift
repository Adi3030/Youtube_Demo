//
//  DetailsVC.swift
//  Youtube
//
//  Created by aditya sharma on 18/05/23.
//

import UIKit

class DetailVCTableCell: UITableViewCell {


    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var viewImgView: UIImageView!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    override class func awakeFromNib() {

    }
}
class DetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var lanLbl: UILabel!

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
        // Do any additional setup after loading the view.
    }

}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.videoImgArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVCTableCell", for: indexPath) as! DetailVCTableCell
        cell.viewImgView.image = UIImage(named: Constants.videoImgArr[indexPath.row])
        cell.profileImgView.image = UIImage(named: Constants.profileIconArr[indexPath.row])
        cell.viewsLbl.text = Constants.viewArr[indexPath.row]
        cell.timeStampLbl.text = Constants.timeStampArr[indexPath.row]
        cell.topicLbl.text = Constants.titleArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
