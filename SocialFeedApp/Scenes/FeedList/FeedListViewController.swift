//
//  FeedListViewController.swift
//  SocialFeedApp
//
//  Created by Raul Mantilla on 28/02/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol FeedListDisplayLogic: class
{
    func displayFeeds(viewModel: FeedList.FetchFeeds.ViewModel)
}

class FeedListViewController: UIViewController, FeedListDisplayLogic
{
    var interactor: FeedListBusinessLogic?
    var router: (NSObjectProtocol & FeedListRoutingLogic & FeedListDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var refresher:UIRefreshControl!
    
    var displayedFeeds: [DisplayedFeed] = []
    var currentPage = 1
    var loading = false
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = FeedListInteractor()
        let presenter = FeedListPresenter()
        let router = FeedListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchFeeds()
        setupCollectionView()
    }
    
    // MARK: Methods
    
    @objc func fetchFeeds()
    {
        let request = FeedList.FetchFeeds.Request(socialId: currentPage)
        interactor?.fetchFeeds(request: request)
        loading = true
    }
    
    func displayFeeds(viewModel: FeedList.FetchFeeds.ViewModel)
    {
        refresher.endRefreshing()
        displayedFeeds.append(contentsOf: viewModel.displayedFeeds)
        loading = false
        collectionView.reloadData()
    }
    
    func loadMorePages(){
        currentPage += 1
        fetchFeeds()
    }
}


// MARK: - UICollectionView Delegates implementation
extension FeedListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UINib(nibName: String(describing: FeedListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FeedListCell.self))
        refresher = UIRefreshControl()
        collectionView!.alwaysBounceVertical = true
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(fetchFeeds), for: .valueChanged)
        collectionView!.addSubview(refresher)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return displayedFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let displayedFeed = displayedFeeds[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedListCell.self), for: indexPath) as? FeedListCell else { return UICollectionViewCell() }
        
        cell.setup(withDisplayedFeed: displayedFeed)
        var frame = cell.pictureImage.frame
        frame.size.height = displayedFeed.pictureHeight(with: collectionView.frame.width - 40)
        cell.pictureImage.frame = frame
        
        if indexPath.row == self.displayedFeeds.count - 1 && !loading {
            currentPage += 1
            self.loadMorePages()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let displayedFeed = displayedFeeds[indexPath.row]
        var height = CGFloat(130.0)
        if let message = displayedFeed.plainText {
            let font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
            
            let size = CGSize(width: collectionView.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame =  NSString(string: message).boundingRect(
                with: size,
                options: options,
                attributes: [NSAttributedString.Key.font: font],
                context: nil)
            height += estimatedFrame.height
        } else {
            height += 0
        }
        
        if displayedFeed.picture?.pictureLink != nil {
            height += displayedFeed.pictureHeight(with: collectionView.frame.width - 40)
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayedFeed = displayedFeeds[indexPath.row]
        router?.showSelectedFeed(with: displayedFeed)
    }
}

