//
//  FeedListPresenter.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol FeedListPresentationLogic
{
    func presentFeeds(response: FeedList.FetchFeeds.Response)
}

class FeedListPresenter: FeedListPresentationLogic
{
    weak var viewController: FeedListDisplayLogic?
    
    // MARK: Methods
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    lazy var visibleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM YYYY"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
    
    func presentFeeds(response: FeedList.FetchFeeds.Response)
    {
        var fetchedFeeds: [DisplayedFeed] = []
        for fetchedFeed in response.fetchedFeeds
        {
            if let dateString = fetchedFeed.date,
                let date = dateFormatter.date(from: dateString){
                let visibleDate = visibleDateFormatter.string(from: date)
                
                var attibutedText: NSMutableAttributedString?
                if let text = fetchedFeed.text,
                    let plain = text.plain,
                    let markups = text.markup {
                    attibutedText = NSMutableAttributedString(string: plain)
                    for link in markups {
                        if let url = URL(string: link.link) {
                            attibutedText?.setAttributes([.link: url], range: NSMakeRange(link.location, link.length))
                        }
                    }
                }
                var socialImage: UIImage?
                switch fetchedFeed.netWorkType() {
                    case .facebook? :
                        socialImage = UIImage(named: "facebook")
                    case .instagram? :
                        socialImage = UIImage(named: "instagram")
                    case .twitter? :
                        socialImage = UIImage(named: "twitter")
                default:
                    socialImage = UIImage(named: "unknown")
                    break
                }
                
                let displayedFeeds = DisplayedFeed(
                    network: socialImage,
                    date: visibleDate,
                    authorName: fetchedFeed.author?.name,
                    authorPictureUrl: fetchedFeed.author?.pictureLink,
                    accountName: fetchedFeed.author?.account,
                    isVerified: fetchedFeed.author?.isVerified,
                    text: attibutedText,
                    plainText: fetchedFeed.text?.plain,
                    picture: fetchedFeed.attachment,
                    link: fetchedFeed.link
                )
                
                fetchedFeeds.append(displayedFeeds)
            }
        }
        let viewModel = FeedList.FetchFeeds.ViewModel(displayedFeeds: fetchedFeeds)
        viewController?.displayFeeds(viewModel: viewModel)
    }
}
