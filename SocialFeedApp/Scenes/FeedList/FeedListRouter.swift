//
//  FeedListRouter.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol FeedListRoutingLogic
{
    func showSelectedFeed(with feed: DisplayedFeed)
}

protocol FeedListDataPassing
{
    var dataStore: FeedListDataStore? { get set }
}

class FeedListRouter: NSObject, FeedListRoutingLogic, FeedListDataPassing
{
    weak var viewController: FeedListViewController?
    var dataStore: FeedListDataStore?
    
    // MARK: Routing
    
    func showSelectedFeed(with feed: DisplayedFeed)
    {
        if let link = feed.link,
           let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
