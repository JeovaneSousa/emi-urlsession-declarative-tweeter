//
//  HTTPRequest.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 26/01/23.
//

import Foundation



class HTTPRequest {
    
    var session: URLSession?
    var dataTask: URLSessionDataTask?
    var urlTemplate = "https://tuitr-api.herokuapp.com/api%@"
    
    init(session: URLSession? = .shared) {
        self.session = session
    }
    
    func execute<T: Codable>(resource: String,
                                 method: HTTPMethods = .GET,
                                 headers: HTTPHeaders? = nil,
                                 body: Codable? = nil,
                                 decoder: JSONDecoder = .init(),
                                 encoder: JSONEncoder = .init(),
                                 completionHandler: @escaping (HTTPResult<T>) -> Void) {
        
        
        let formattedString = String(format: urlTemplate, resource)
        
        guard let url = URL(string: formattedString) else {
            fatalError("Unable to create url for request")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            headers.forEach { (headerKey, value) in request.setValue(value, forHTTPHeaderField: headerKey)}
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let body = body {
            do {
                request.httpBody = try encoder.encode(body)
                debugPrint(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            } catch let error{
                let contextError = NetworkError.invalidData(error)
                
                completionHandler(.failure(.unableToPerformRequest(contextError)))
                return
            }
        }
        
        dataTask?.cancel()
        
        dataTask = session?.dataTask(with: request) { [weak self] data, response, error in
            
            defer {
                self?.dataTask = nil
            }
            
            let result: HTTPResult<T> = DataTaskResult(data: data, error: error)
            
                .mapError { error in return NetworkError.unableToPerformRequest(error)}
            
                .flatMap { data in return Result { try decoder.decode(T.self, from: data) }}
            
                .flatMapError { error in
                    if let error = error as? NetworkError {
                        return .failure(error)
                    }
                    
                    if let response = response as? HTTPURLResponse, !response.isInSuccessRange {
                        return .failure(.requestFailed(response.statusCode))
                    }
                    
                    return .failure(.invalidData(error))
                }
            
            completionHandler(result)
        }
        
        dataTask?.resume()
    }
    
}

enum NetworkError: Swift.Error, LocalizedError {
    case unableToPerformRequest(Error)
    case requestFailed(Int)
    case invalidData(Error)
    
    var errorMessage: String {
        switch self {
            
        case .unableToPerformRequest(let error):
            return "Unable to perform request because of the following error: \(error.localizedDescription)."
            
        case .requestFailed(let statusCode):
            return "Request failed. Status code of the response was: \(statusCode)"
            
        case .invalidData(let error):
            return "Unable to parse data. Here is the cause: \(error.localizedDescription)"
        }
    }
}
