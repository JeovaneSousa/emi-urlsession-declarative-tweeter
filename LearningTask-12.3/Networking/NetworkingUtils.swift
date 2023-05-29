//
//  NetworkingUtils.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 02/02/23.
//

import Foundation


enum HTTPMethods: String {
    case GET,POST,PUT,DELETE
}

typealias ApiResult<T> = Result<T, TweetApiError>
typealias HTTPHeaders = [String: String]
typealias HTTPResult<T> = Result<T, NetworkError>
typealias DataTaskResult = Result<Data, Error>

extension HTTPURLResponse {
    var isInSuccessRange: Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}

extension Result {
    init(data: Success?, error: Failure? ) {
        if let error = error {
            self = Result.failure(error)
            return
        }
        
        if let data = data {
            self = .success(data)
            return
        }
        
        preconditionFailure("Unable to create result.")
    }
}
