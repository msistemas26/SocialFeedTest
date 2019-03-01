//
//  FeedListInteractor.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol FeedListBusinessLogic
{
    func fetchFeeds(request: FeedList.FetchFeeds.Request)
}

protocol FeedListDataStore
{
    var fetchedFeeds: [Feed] { get set }
    var selectedFeed: Feed? { get set }
}

class FeedListInteractor: FeedListBusinessLogic, FeedListDataStore
{
    var presenter: FeedListPresentationLogic?
    var worker: FeedListWorker?
    var fetchedFeeds: [Feed] = []
    var selectedFeed: Feed?
    
    // MARK: Methods
    
    func fetchFeeds(request: FeedList.FetchFeeds.Request)
    {
        worker = FeedListWorker()
        worker?.fetchFeeds(socialId: request.socialId){ (fetchedFeeds) in
            self.fetchedFeeds = fetchedFeeds
            let response = FeedList.FetchFeeds.Response(fetchedFeeds: fetchedFeeds)
            self.presenter?.presentFeeds(response: response)
         }
    }
}
