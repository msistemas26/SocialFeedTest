//
//  AppDelegate.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 15/02/19.
//  Copyright © 2019 Raul Mantilla Assia. All rights reserved.
//

import Foundation
import Alamofire

enum AppPath
{
    static let socialPath = "https://storage.googleapis.com/cdn-og-test-api/test-task/social/social_id.json"
}

final class DataProviderApi
{
    
    init()
    {
        //TO DO
    }
    
    func fetchSocialFeeds(socialId: String, completionHandler completion: @escaping ([Feed]) -> Void)
    {
        let urlString = AppPath.socialPath.replacingOccurrences(of: "social_id", with: String(socialId))
        
        print(urlString)
        
        Alamofire
            .request(urlString, method: .get)
            .responseJSON { response in
                guard let jsonData = response.data else {
                    completion([])
                    return
                }
                do {
                    let decoder = JSONDecoder()
                      decoder.dateDecodingStrategy = .iso8601
                    let feeds = try decoder.decode([Feed].self, from:
                            jsonData)
                     completion(feeds)
                } catch let parsingError {
                    print("Error", parsingError)
                    completion([])
                }
        }
    }
}
