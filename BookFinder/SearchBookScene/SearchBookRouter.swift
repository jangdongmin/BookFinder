//
//  SearchBookRouter.swift
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

@objc protocol SearchBookRoutingLogic
{
    func routeToDetail(index: Int)
}

protocol SearchBookDataPassing
{
    var dataStore: SearchBookDataStore? { get }
}

class SearchBookRouter: NSObject, SearchBookRoutingLogic, SearchBookDataPassing
{
    weak var viewController: SearchBookViewController?
    var dataStore: SearchBookDataStore?
    
    // MARK: Routing
    
    func routeToDetail(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailBookViewController") as! DetailBookViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetail(source: dataStore!, destination: &destinationDS, selectIndex: index)
        navigateToDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToDetail(source: SearchBookViewController, destination: DetailBookViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetail(source: SearchBookDataStore, destination: inout DetailBookDataStore, selectIndex: Int)
    {
        destination.bookModel = source.bookModel[selectIndex]
    }
}
