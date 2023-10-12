//
//  ViewController.swift
//  07_08_2023_JSONSerializationDemoWay1
//
//  Created by Vishal Jagtap on 12/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       fetchData()
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
            }
        }
        dataTask.resume()
    }
}
