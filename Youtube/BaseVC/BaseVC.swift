//
//  BaseVC.swift
//  CustomSideMenuiOSExample
//
//  Created by aditya sharma on 09/04/23.
//

import UIKit

class BaseVC: UIViewController {
    static let shared = BaseVC()

    var userLoginStatus: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginStatus = UserDefaults.standard.value(forKey: "isUserLoggedIn") as? Bool

        addMenuBarButton()
        // Do any additional setup after loading the view.
    }
    
    func addMenuBarButton() {
        //Add SideMenu Button to the Navigation Bar
        let image = UIImage(named: "youtube")
        let backItem = UIBarButtonItem(image: image,
                                       style: .plain,
                                       target: self,
                                       action: #selector(showSideMenu))
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        //Add Notification Icon to the Navigation Bar
        let bellImage = UIImage(named: "globe")
        let bellBtn = UIBarButtonItem(image: bellImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(gloabClicked))
        self.navigationItem.rightBarButtonItem = bellBtn
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        title = "JAMERICAN TRAVEL"
        
        //Add Navigation Title
//        let titleImage = UIImage(named: "logopng")
//        let imageView = UIImageView(image: titleImage)
//        self.navigationItem.titleView = imageView
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    

    //MARK: Notification Button Action
    @objc func gloabClicked() {

//        let objVC = self.storyboard!.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//            self.navigationController?.pushViewController(objVC, animated: true)
          }
    @objc func showSideMenu() {

//        let objVC = self.storyboard!.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//            self.navigationController?.pushViewController(objVC, animated: true)
          }

}
extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
