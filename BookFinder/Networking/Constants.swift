//
//  Constants.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/17.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import Foundation

struct ApiInfo {
    static let baseURL = "https://www.googleapis.com"
    static let appKey = "AIzaSyB4c4YmZwvb1sSChweTFTSUwgfcMvjVY2Y"
    static let itemCount = "10"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

 
