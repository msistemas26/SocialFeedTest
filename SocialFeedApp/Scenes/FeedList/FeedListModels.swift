//
//  FeedListModels.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

enum FeedList
{
    // MARK: Use cases
    enum FetchFeeds
    {
        struct Request
        {
            let socialId: Int
        }
        struct Response
        {
            var fetchedFeeds: [Feed]
        }
        struct ViewModel
        {
            var displayedFeeds: [DisplayedFeed]
        }
    }
}

struct DisplayedFeed
{
    let network: UIImage?
    let date: String?
    let authorName: String?
    let authorPictureUrl: String?
    let accountName: String?
    let isVerified: Bool?
    let text: NSMutableAttributedString?
    let plainText: String?
    let picture: Attachment?
    let link: String?
    
    func pictureHeight(with width: CGFloat) -> CGFloat {
        if let picture = picture{
            return (CGFloat(picture.height) * width) / CGFloat(picture.width)
        }
        return 0
    }
}
            
