//
//  DetailBookInteractor.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/20.
//  Copyright (c) 2020 Paul Jang. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftyJSON
protocol DetailBookBusinessLogic
{
    func setupBookInfoUI()
}

protocol DetailBookDataStore
{
    var bookModel: BookInfo.BookModel { get set }
}

class DetailBookInteractor: DetailBookBusinessLogic, DetailBookDataStore
{
    var presenter: DetailBookPresentationLogic?
    var worker: DetailBookWorker?
    var bookModel = BookInfo.BookModel(title: "", author: [], publishedDate: "", thumbnail: "", pageCount: 0, subtitle: "", publisher: "", description: "")
    
    // MARK: Do something
    
    func setupBookInfoUI()
    {
        let response = DetailBook.Response(bookModel: bookModel)
        presenter?.presentUI(response: response)
    }
}
