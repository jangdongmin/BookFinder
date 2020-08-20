//
//  BookDetailInfoTableView.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/20.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import UIKit

class BookDetailInfoTableView: UITableView {
    var bookData: [(String, String)]?
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    public func setData(bookData: [(String, String)]) {
        self.bookData = bookData
        self.reloadData()
    }
}

extension BookDetailInfoTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailInfoTableViewCell.self), for: indexPath) as? BookDetailInfoTableViewCell {
            
            cell.titleLabel.text = bookData?[indexPath.row].0
            cell.contentLabel.text = bookData?[indexPath.row].1
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
