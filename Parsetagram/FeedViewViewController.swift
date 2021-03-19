//
//  FeedViewViewController.swift
//  Parsetagram
//
//  Created by Bhumi Patel on 3/17/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        
        //get the query, store data, and reloaded
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        //let currentUser = PFUser.current()!["username"] as? String
        //cell.currentUserLabel.text = "@" + currentUser!
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = "@" + user.username!
        
        
        let caption = post["caption"] as! String
        cell.captionLabel.text = caption
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
        
        return cell
        
        
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
