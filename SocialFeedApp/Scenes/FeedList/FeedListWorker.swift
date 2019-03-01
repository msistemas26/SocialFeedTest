//
//  FeedListWorker.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

class FeedListWorker
{
    let dataProviderApi = DataProviderApi()
    
    func fetchFeeds(socialId: Int, completionHandler completion: @escaping ([Feed]) -> Void)
    {
        dataProviderApi.fetchSocialFeeds(socialId: String(socialId)){ (feeds) in
            completion(feeds)
        }
    }
}
