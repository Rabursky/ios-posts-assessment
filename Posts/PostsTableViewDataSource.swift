//
//  PostsTableViewDataSource.swift
//  Posts
//
//  Created by Marcin Raburski on 22.05.2016.
//  Copyright © 2016 Rzeczy. All rights reserved.
//

import UIKit
import Domain

class PostsTableViewDataSource: NSObject, UITableViewDataSource {
    var posts: [PostModel] = [PostModel]()
    
    func postForIndexPath(indexPath: NSIndexPath) -> PostModel {
        return self.posts[indexPath.row]
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = self.postForIndexPath(indexPath)
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = post.title
        cell?.accessibilityLabel = post.title
        return cell!
    }
}
