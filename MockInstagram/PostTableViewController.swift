//
//  PostTableViewController.swift
//  MockInstagram
//
//  Created by Zhaoya Sun on 12/27/17.
//  Copyright © 2017 Zhaoya Sun. All rights reserved.
//

import UIKit
import Parse

class PostTableViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        getPosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func getPosts() {
        Post.getPosts(success: { (posts: [Post]) in
            self.posts = posts
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (error: Error?) in
            print("error: \(error?.localizedDescription)")
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
                NotificationCenter.default.post(name: PFUser.userDidLogoutNotification, object: nil)
            } else {
                // Display error
            }
        }
    }
    
}

// UITableView methods
extension PostTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! photoCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 425
    }
}


