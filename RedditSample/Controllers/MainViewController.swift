//
//  MainViewController.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/21/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import UIKit
import SafariServices
import CleanroomLogger

class MainViewController: UIViewController, ViewModelContainer, canBlockView {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListingsViewModel = ListingsViewModel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MainViewController.handleRefresh(refreshControl:)), for: .valueChanged)
        
        return refreshControl
    }()

    // MARK: - View Controller / Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)
        tableView.allowsMultipleSelection = false
        
        // Do any additional setup after loading the view.
        self.blockUI()
        viewModel.loadData {
            self.unblockUI()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - TableView Functions
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.listings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = RedditURLS.Categories.allValues[section]
        return (viewModel.listings[category]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: TableConstants.SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 0.0/255.0, green: 159.0/255.0, blue: 252.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: TableConstants.SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        let category = RedditURLS.Categories.allValues[section]
        label.text = category.rawValue
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let category = RedditURLS.Categories.allValues[indexPath.section]
        
        let listing = viewModel.getListing(for: category, at: indexPath)
        cell.textLabel?.text = listing.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = RedditURLS.Categories.allValues[indexPath.section]
        
        let listing = viewModel.getListing(for: category, at: indexPath)
        let url = URL(string: listing.link!)!
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    // MARK: - Table Refresh
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        viewModel.loadData {
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}
