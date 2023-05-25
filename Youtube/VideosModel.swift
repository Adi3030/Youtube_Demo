//
//  VideosModel.swift
//  Youtube
//
//  Created by aditya sharma on 22/05/23.
//

struct VideosModel: Codable {
    var videos:[video]
}

struct video: Codable {
    var id: Int
    var title: String
    var thumbnail: String
    var channelName: String
    var profilePic: String
    var views: String
    var timeStamp: String
  
}
