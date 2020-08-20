//
//  APIClient.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/17.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static func getBookInfo(bookName: String, page: Int, completion: @escaping (Result<Any, AFError>) -> Void) {
        AF.request(UserEndpoint.searchBook(bookName: bookName, page: page)).validate().responseJSON { response in
            completion(response.result)
        }
    }
}
