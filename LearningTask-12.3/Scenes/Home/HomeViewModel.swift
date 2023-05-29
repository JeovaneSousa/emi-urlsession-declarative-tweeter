//
//  HomeViewModel.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 20/01/23.
//

import Foundation

protocol HomeFeedViewControllerDelegate: AnyObject {
    func HomeFeedViewControllerDelegate(viewModel: HomeViewModel, didLoadFeedPosts posts: [FeedPost])
    func HomeFeedViewControllerDelegate(viewModel: HomeViewModel, errorOccurred error: TweetApiError)
}

class HomeViewModel {
    
    var posts: [FeedPost] = [] {
        didSet {
            delegate?.HomeFeedViewControllerDelegate(viewModel: self, didLoadFeedPosts: posts)
        }
    }
    
    var tweetApi: TweetAPI?
    
    weak var delegate: HomeFeedViewControllerDelegate?
    
    func carregaFeed(){
        tweetApi?.carregaFeed { [weak self] (result: ApiResult<[FeedPost]>) in
            
            guard let self = self else {return}
            
            switch result {
                
            case .success(let posts):
                self.posts = posts
                
            case .failure(let apiError):
                debugPrint(apiError.errorMessage)
                self.delegate?.HomeFeedViewControllerDelegate(viewModel: self, errorOccurred: apiError)
            }
        }
    }
    
}
    
    

