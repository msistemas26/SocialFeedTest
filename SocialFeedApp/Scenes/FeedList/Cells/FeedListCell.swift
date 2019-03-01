//
//  FeedListCell.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FeedListCell: UICollectionViewCell {
    
    @IBOutlet weak var authorNameLabel: UILabel! {
        didSet {
            authorNameLabel.textColor = DefaultColors.blackColor
            authorNameLabel.font = DefaultFonts.regular
        }
    }
    @IBOutlet weak var accountNameLabel: UILabel! {
        didSet {
            accountNameLabel.textColor = DefaultColors.blackColor
            accountNameLabel.font = DefaultFonts.regular
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = DefaultColors.blackColor
            dateLabel.font = DefaultFonts.regular
        }
    }
    
    @IBOutlet weak var plainTextView: UITextView! {
        didSet {
            dateLabel.textColor = DefaultColors.blackColor
            dateLabel.font = DefaultFonts.regular
        }
    }
    
    @IBOutlet weak var networkImage: UIImageView!{
        didSet {
            networkImage.backgroundColor = DefaultColors.bgColor
            networkImage.layer.cornerRadius = 10
            networkImage.layer.masksToBounds = false
            networkImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var authorImage: UIImageView!{
        didSet {
            authorImage.backgroundColor = DefaultColors.bgColor
            authorImage.layer.cornerRadius = 30
            authorImage.layer.masksToBounds = false
            authorImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = DefaultColors.bgColor
            bgView.layer.cornerRadius = 10
        }
    }
    
    var displayedFeed: DisplayedFeed!
    
    func setup(withDisplayedFeed displayedFeed: DisplayedFeed) {
        self.displayedFeed = displayedFeed
        showData()
    }
    
    private func showData() {
        authorNameLabel.text = displayedFeed.authorName
        dateLabel.text = displayedFeed.date
        plainTextView.attributedText = displayedFeed.text
        plainTextView.isUserInteractionEnabled = true
        plainTextView.isEditable = false
        plainTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        if let accounName = displayedFeed.accountName {
            accountNameLabel.text = accounName
            accountNameLabel.isHidden = false
        }
        
        if let imageUrl = displayedFeed.authorPictureUrl,
            let url = URL(string: imageUrl)  {
            authorImage.af_setImage(withURL: url)
        }
        
        if let imageUrl = displayedFeed.picture?.pictureLink,
            let url = URL(string: imageUrl)  {
            pictureImage.af_setImage(withURL: url)
        }
        
        if let image = displayedFeed.network {
            networkImage.image = image
        }
    
        if displayedFeed.isVerified == true {
            verifiedImage.isHidden = false
        }
    }
}
