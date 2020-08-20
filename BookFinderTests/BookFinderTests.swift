//
//  BookFinderTests.swift
//  BookFinderTests
//
//  Created by Paul Jang on 2020/08/21.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import XCTest
@testable import BookFinder

class BookFinderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBookSearch() throws {
        let promise = expectation(description: "Completion handler invoked")
        let interactor = SearchBookInteractor()
        interactor.searchBook(request: BookInfo.Request(q: "swift", page: 0), completion: { result in
            switch result {
                case .success( _):
                    break
                case .failure( _):
                    break
            }
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 3, handler: nil)
        
        if interactor.bookModel.isEmpty {
            XCTAssertTrue(false)
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func testBookSearchContinuous() throws {
        let promise = expectation(description: "Completion handler invoked")
        let promise2 = expectation(description: "Completion handler invoked")
        let interactor = SearchBookInteractor()
        
        interactor.searchBook(request: BookInfo.Request(q: "swift", page: 0), completion: { result in
            switch result {
                case .success( _):
                    break
                case .failure( _):
                    break
            }
            
            promise.fulfill()
        })
         
        interactor.searchBook(request: BookInfo.Request(q: "ios", page: 0), completion: { result in
            switch result {
                case .success( _):
                    break
                case .failure( _):
                    break
            }
            
            promise2.fulfill()
        })
        
        waitForExpectations(timeout: 3, handler: nil)
        
        if interactor.bookModel.count == 10 {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testBookSearchPaging() throws {
        let promise = expectation(description: "Completion handler invoked")
        let promise2 = expectation(description: "Completion handler invoked")
        let interactor = SearchBookInteractor()
        
        interactor.searchBook(request: BookInfo.Request(q: "swift", page: 0), completion: { result in
            switch result {
                case .success( _):
                    
                    interactor.searchBook(request: BookInfo.Request(q: "swift", page: 1), completion: { result in
                        switch result {
                            case .success( _):
                                break
                            case .failure( _):
                                break
                        }
                        
                        promise2.fulfill()
                    })
                    
                    break
                case .failure( _):
                    break
            }
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 3, handler: nil)
        
        if interactor.bookModel.count == 20 {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
}
