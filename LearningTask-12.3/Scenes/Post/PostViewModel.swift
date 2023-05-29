//
//  PostViewModel.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 30/01/23.
//

import Foundation

protocol PostViewModelDelegate: AnyObject {
    func PostViewModelDelegate(in viewModel: PostViewModel, didPostTuit feedPost: FeedPost)
    func PostViewModelDelegate(in viewModel: PostViewModel, foundError error: TweetApiError)
}

class PostViewModel {
    var tweetApi: TweetAPI?
    
    weak var delegate: PostViewModelDelegate?
    
    func postTuit(comTuit feedPostInput: FeedPostInput)  {
        tweetApi?.postaTuit(withPost: feedPostInput, completionHandler: { [weak self] (result: ApiResult<FeedPost>) in
            
            guard let self = self else {return}
            
            switch result {
                
            case .success(let post):
                self.delegate?.PostViewModelDelegate(in: self, didPostTuit: post)
            
            case .failure(let apiError):
                debugPrint(apiError)
                self.delegate?.PostViewModelDelegate(in: self, foundError: apiError)
                
            }
        })
    }
    
}
