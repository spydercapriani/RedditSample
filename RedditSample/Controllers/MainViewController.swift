//
//  MainViewController.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/21/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import UIKit
import SafariServices
import AlamofireImage
import CleanroomLogger

class MainViewController: UIViewController, ViewModelContainer, canBlockView {
    
    // MARK: - Properties
    
    @IBOutlet weak var navTitle: UINavigationItem!
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
        navTitle.title = "/r/\(viewModel.subreddit)"
        
        tableView.addSubview(refreshControl)
        
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
    
    // MARK: - Button Actions
    
    @IBAction func searchAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Subreddit", message: "Want to follow a different Subreddit?", preferredStyle: .alert)
        
        alertController.addTextField { (subredditTextField: UITextField!) in
            subredditTextField.placeholder = "Enter Subreddit Here"
        }
        
        let followAction = UIAlertAction(title: "Follow", style: .default) { (alert) in
            let subredditTextField = alertController.textFields![0] as UITextField
            
            self.viewModel.subreddit = subredditTextField.text!.isEmpty ? self.viewModel.subreddit : subredditTextField.text!
            self.viewDidLoad()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        alertController.addAction(followAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - TableView Functions
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.listings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = RedditConstants.Categories.allValues[section]
        return (viewModel.listings[category]?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: TableConstants.SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 0.0/255.0, green: 159.0/255.0, blue: 252.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: TableConstants.SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        let category = RedditConstants.Categories.allValues[section]
        label.text = category.rawValue
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableConstants.CellIdentifiers.cell.rawValue, for: indexPath) as! RedditLinkCell
        let listing = viewModel.getListing(for: indexPath)
        let placeholder = UIImage(named: "placeholderImage")
        
        cell.titleLabel.text = listing.title
        if let urlString = URL(string: listing.thumbnail ?? "") {
            cell.thumbnailImage.af_setImage(withURL: urlString, placeholderImage: placeholder)
        }else {
            cell.thumbnailImage.image = placeholder
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listing = viewModel.getListing(for: indexPath)
        let url = URL(string: listing.link)!
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
