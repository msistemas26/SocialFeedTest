//
//  Social.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 15/02/19.
//  Copyright © 2019 Raul Mantilla Assia. All rights reserved.
//

import Foundation

enum NetWorkType: String {
    case facebook = "facebook"
    case twitter = "twitter"
    case instagram = "instagram"
}

struct Feed : Codable {
    let author: Author?
    let date: String?
    let link: String?
    let network: String?
    let attachment: Attachment?
    let text: ContentText?
    
    struct Author : Codable {
        let account: String?
        let isVerified: Bool?
        let name: String?
        let pictureLink: String?
        
        enum CodingKeys: String, CodingKey {
            case isVerified = "is-verified"
            case name
            case account
            case pictureLink = "picture-link"
        }
    }
    
    struct ContentText : Codable {
        let plain: String?
        let markup: [TextMarkup]?
        
        enum CodingKeys: String, CodingKey {
            case plain
            case markup
        }
        
        struct TextMarkup : Codable {
            let length: Int
            let location: Int
            let link: String
        }
    }
    
    func netWorkType() -> NetWorkType? {
        if let networkType = network {
            return NetWorkType(rawValue: networkType)
        }
        return nil
    }
}

struct Attachment : Codable {
    let pictureLink: String?
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case pictureLink = "picture-link"
        case width
        case height
    }
}
