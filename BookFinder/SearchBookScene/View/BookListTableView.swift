//
//  BookListTableView.swift
//  BookFinder
//
//  Created by Paul Jang on 2020/08/19.
//  Copyright © 2020 Paul Jang. All rights reserved.
//

import UIKit
import SDWebImage

protocol BookListTableViewDelegate: class {
    func nextPage(page: Int)
    func select(index: Int)
}


class BookListTableView: UITableView {
    weak var bookListTableViewDelegate: BookListTableViewDelegate?
    var viewModel: BookInfo.ViewModel?
    
    var isLoading = false
    var page = 0
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    public func setData(viewModel: BookInfo.ViewModel) {
        isLoading = false
        self.viewModel = viewModel
        self.reloadData()
    }
}


extension BookListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookListTableViewDelegate?.select(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.bookData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookListTableViewCell.self), for: indexPath) as? BookListTableViewCell {
            
            cell.titleLabel.text = viewModel?.bookData[indexPath.row].title
            cell.dateLabel.text = viewModel?.bookData[indexPath.row].publishedDate
            cell.authorLabel.text = viewModel?.bookData[indexPath.row].author.reduce("", { (s1: String, s2: String) -> String in
                if s1 == "" {
                    return s1 + s2
                }
                return s1 + " , " + s2
            })
            cell.bookImageVIew.sd_setImage(with: URL(string: viewModel?.bookData[indexPath.row].thumbnail ?? ""), placeholderImage: UIImage(named: "placeholder"))
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + self.frame.size.height
        if offsetY > self.contentSize.height / 2 && !isLoading && viewModel?.itemTotalCount ?? 0 > viewModel?.bookData.count ?? 0 {
            isLoading = true
            page += 1
            bookListTableViewDelegate?.nextPage(page: page)
       }
    }
}
