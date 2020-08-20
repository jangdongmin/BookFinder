//
//  SearchBookWorker.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/19.
//  Copyright (c) 2020 Paul Jang. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class SearchBookWorker {
    func search(keyword: String, page: Int, completion: @escaping (Result<Any, Error>) -> Void) {
        APIClient.getBookInfo(bookName: keyword, page: page) { result in
            switch result {
            case .success(let books):
                completion(.success(books))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
                
            }
        }
    }
}