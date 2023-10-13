//
//  ViewController.swift
//  07_08_2023_JSONSerializationDemoWay1
//
//  Created by Vishal Jagtap on 12/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var postTableView: UITableView!
    private let postTableViewCellReuseIdentifier : String = "PostTableViewCell"
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registerXIBWithPostTableView()
        fetchData()
    }
    
    func initializeTableView(){
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func registerXIBWithPostTableView(){
        let uiNib = UINib(nibName: postTableViewCellReuseIdentifier, bundle: nil)
        postTableView.register(uiNib, forCellReuseIdentifier: postTableViewCellReuseIdentifier)
    }
    
    func fetchData(){
        //Step 1 : extract url from urlstring
       let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        //step 2 : urlRequest Object
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        //step 3 : url session
        let urlSession = URLSession(configuration: .default)
        
        //step 4 : dataTask
        let dataTask = urlSession.dataTask(with: urlRequest){ data, response, error in
            
            print("Data is : \(data)")
            print("Response is : \(response)")
            print("Error is : \(error)")
            
        //step 5 : json serialization
        let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
        
            for eachPostDictionary in apiResponse{
                let eachDictionary = eachPostDictionary as [String : Any]
                
                let userId = eachDictionary["userId"] as! Int
                let id = eachDictionary["id"] as! Int
                let title = eachDictionary["title"] as! String
                let body = eachDictionary["body"] as! String
                
                let newPostObject = Post(userId: userId, id: id, title: title, body: body)
                
                self.posts.append(newPostObject)
                print("userId -- \(userId) Id -- \(id)")
            }
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: postTableViewCellReuseIdentifier, for: indexPath) as! PostTableViewCell
    
        postTableViewCell.postUserId.text = String(posts[indexPath.row].userId)
        postTableViewCell.idLabel.text = String(posts[indexPath.row].id)
        postTableViewCell.titleLabel.text = posts[indexPath.row].title
        postTableViewCell.bodyLabel.text = posts[indexPath.row].body
        
        return postTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.0
    }
}
