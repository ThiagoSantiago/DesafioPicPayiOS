//
//  ContactsListViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ContactListProtocol: class {
    func hideLoadingView()
    func displayLoadingView()
    func displayError(_ message: String)
    func displayUsers(_ list: [UserViewModel])
}


class ContactsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var interactor: ContactListInteractor?
    var tableViewData: [UserViewModel] = []
    
    let maxHeight: CGFloat = 175
    let minHeight: CGFloat = 100
    var previousScrollOffset: CGFloat = 0
    
    init(interactor: ContactListInteractor) {
        super.init(nibName: "ContactsListViewController", bundle: Bundle.main)
        self.interactor = interactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        interactor?.getUsersList()
    }

    private func configViews() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.headerHeightConstraint.constant = self.maxHeight
        
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "ContactListCell", bundle: nil), forCellReuseIdentifier: "ContactListCell")
    }
}

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as? ContactListCell else {
            return UITableViewCell()
        }
        
        cell.setContent(user: tableViewData[indexPath.row])
        
        return cell
    }
    
}

extension ContactsListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateHeader(self.tableView) {
            var newHeight = self.headerHeightConstraint.constant
            
            if isScrollingDown {
                newHeight = max(self.minHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }
        
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.setScrollPosition(position: self.previousScrollOffset)
            }
        }
        
        self.previousScrollOffset = scrollView.contentOffset.y
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeight - self.minHeight
        let midPoint = self.minHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    private func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeight
            self.view.layoutIfNeeded()
        })
    }
    
    private func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeight
            self.view.layoutIfNeeded()
        })
    }
    
    private func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - self.minHeight
        
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    private func setScrollPosition(position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
}

extension ContactsListViewController: ContactListProtocol {
    func hideLoadingView() {
        // implement the hideLoadingView
    }
    
    func displayLoadingView() {
        // implement the displayLoadingView
    }
    
    func displayError(_ message: String) {
        // implement the displayError
    }
    
    func displayUsers(_ list: [UserViewModel]) {
        self.tableViewData = list
        self.tableView.reloadData()
    }
}
