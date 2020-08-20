//
//  SearchBookPresenter.swift
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
import SwiftyJSON

protocol SearchBookPresentationLogic
{
    func presentBookList(response: BookInfo.Response)
}

class SearchBookPresenter: SearchBookPresentationLogic
{
    weak var viewController: SearchBookDisplayLogic?
    
    // MARK: Do something
    
    func presentBookList(response: BookInfo.Response)
    {
        let viewModel = BookInfo.ViewModel(bookData: response.bookModel, itemTotalCount: response.totalItems, page: response.page)
        viewController?.displayBookList(viewModel: viewModel)
    }
}