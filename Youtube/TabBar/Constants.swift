//
//  File.swift
//  Tallr
//
//  Created by Chandra on 04/06/22.
//

import Foundation
import UIKit
import MapKit


//MARK: App Useful details
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let networkIssueTitle = "Network Error"
let networkIssue = "The Internet connection appears to be offline."

//MARK: StoryBoard
let MAIN_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
let HOME_STORYBOARD = UIStoryboard(name: "Home", bundle: nil)

//MARK: App Colors

class Constants {
    

    static var headerArr = ["B Praak",
                            "Game",
                            "Sports",
                            "Bollywood",
                            "Music",
                            "Live",
                            "Sarddha",
                            "News",
                            "Movie",
                            "Rating",
                            "Stram",
                            "Feedback",
                            "Ajay",
                            "Arijit"]
    static var shortsArr = ["aa","bb","cc", "dd", "ee", "ff", "gg", "ii", "dd", "ee"]

    static let videoImgArr = [
        "Screen_1",
        "Screen_2",
        "Screen_3",
        "Screen_4",
        "Screen_5"
    ]
    static let profileIconArr = [
        "Profile_1",
        "Profile_2",
        "Profile_3",
        "Profile_4",
        "Profile_5"

    ]

    static let timeStampArr = [
        "10:12 PM",
        "1 year ago",
        "1 day ago",
        "7 year ago",
        "12:27 AM"
    ]

    static let viewArr = [
        "1k",
        "1.6k ",
        "12k",
        "1M",
        "120k"
    ]
    static let titleArr = [
        "How to use TableView Cell in Swift 5 iOS",
        "Make multiple cell as resuable in Swift",
        "All about UI Of Swift 5 iOS",
        "How to add Placeholder in UITextField in Swift 5",
        "Design Pattern in Swift iOS"
    ]

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
     static func isvalidpassword(_ mypassword : String) -> Bool {
        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    
    static let googleAPIKey = "AIzaSyDnoKHzimZiK450SAyR-koB4Zjc0GrIBSk"
    
  static func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}

class Singleton {
    
    static let shared: Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    static var userId = UserDefaults.standard.string(forKey: "userId") ?? ""
       
        
    static  var apiKey = "rssc123#"
       
    
    

    
    static func isUserLogin() -> Bool {
        
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return false
        }
        return true
        
    }
    
}

struct userDetails {
    var name: String?
    var email: String?
    var userId: String?
    var mobile: String?
}

struct Color {
    
    static let redColor = UIColor(red: 239/255.0, green: 94/255.0, blue: 57/255.0, alpha: 1.0)
    static let greencolor = UIColor(red: 55/255.0, green: 125/255.0, blue: 49/255.0, alpha: 1.0)
    static let corsorGreenColor =  UIColor(red: 55/255.0, green: 125/255.0, blue: 49/255.0, alpha: 1.0)
    static let tintColor =  UIColor(red: 74/255.0, green: 123/255.0, blue: 255/255.0, alpha: 1.0)


}
//   extension MKMapView {
//    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
//        let coordinateRegion = MKCoordinateRegion(
//            center: location.coordinate,
//            latitudinalMeters: regionRadius,
//            longitudinalMeters: regionRadius)
//        setRegion(coordinateRegion, animated: true)
//    }
//}



import SystemConfiguration

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }


        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}



///// New Response
///
///

class ImageLoader {

    var cache = NSCache<AnyObject, AnyObject>()

    class var sharedInstance : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }

    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData

        if let imageData = data {
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async {
                completionHandler(image, urlString)
            }
            return
        }
         
        if urlString == nil || urlString == "" {
            return
        }
        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            if error == nil {
                if data != nil {
                    let image = UIImage.init(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                }
            } else {
                completionHandler(nil, urlString)
            }
        }
        downloadTask.resume()
    }
}





