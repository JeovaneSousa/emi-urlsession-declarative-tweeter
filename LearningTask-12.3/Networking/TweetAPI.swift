//
//  TweetAPI.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 26/01/23.
//

import Foundation

class TweetAPI {
    
    var httpRequest: HTTPRequest
    var userAuthentication: UserAuthentication
    
    init(httpRequest: HTTPRequest = .init(),
         userAuthentication: UserAuthentication = .init()) {
        self.httpRequest = httpRequest
        self.userAuthentication = userAuthentication
    }
    
    func carregaFeed(completionQueue: DispatchQueue = .main,
                      completionHandler: @escaping (ApiResult<[FeedPost]>) -> Void) {
        
        guard let authentication = userAuthentication.get() else { preconditionFailure("Unable to authenticate") }
 
        let headers: HTTPHeaders = ["Authorization": authentication.value]
        
        httpRequest.execute(resource: "/feed",
                            method: .GET,
                            headers: headers,
                            decoder: JSONDecoder.decodingFormattedDates(with: .dateAndTime)) { (result: HTTPResult<[FeedPost]>) in
            
            switch result {
                
            case .success(let posts):
                completionQueue.async {
                    completionHandler(.success(posts))
                }
                
            case .failure(let error):
                completionQueue.async {
                    completionHandler(.failure(.executionError(error)))
                }
            }
        }
    }
    
    func postaTuit(withPost postInput: FeedPostInput,
                   completionQueue: DispatchQueue = .main,
                   completionHandler: @escaping (ApiResult<FeedPost>) -> Void) {
        
        guard let authentication = userAuthentication.get() else { preconditionFailure("Unable to authenticate") }
        
        let headers: HTTPHeaders = ["Authorization": authentication.value]
        
        httpRequest.execute(resource: "/post",
                            method: .POST,
                            headers: headers,
                            body: postInput) { (result: HTTPResult<FeedPost>) in
            
            switch result {
            case .success(let feedPostOutput):
                completionQueue.async {
                    completionHandler(.success(feedPostOutput))
                }
                
            case.failure(let error):
                completionQueue.async {
                    completionHandler(.failure(.executionError(error)))
                }
            }
        }
    }
    
}

enum TweetApiError: Error, LocalizedError {
    
    case executionError(NetworkError)
    
    var errorMessage: String {
        switch self {
        case .executionError(let networkError):
            return "An error occurred: \(networkError.errorMessage)"
        }
    }
}
