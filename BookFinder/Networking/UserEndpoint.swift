//
//  UserEndpoint.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/17.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum UserEndpoint: APIConfiguration {
    case searchBook(bookName: String, page: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .searchBook:
                return .get
        }
    }
    
    //https://www.googleapis.com/books/v1/volumes?q=flowers+inauthor:keyes&key=AIzaSyB4c4YmZwvb1sSChweTFTSUwgfcMvjVY2Y

    // MARK: - Path
    var path: String {
        switch self {
        case .searchBook:
            return "/books/v1/volumes"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .searchBook(let value):
            return ["q" : value.bookName, "key" : ApiInfo.appKey, "startIndex" : value.page, "maxResults" : ApiInfo.itemCount]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ApiInfo.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
