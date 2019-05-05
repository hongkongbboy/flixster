//
//  TrailerViewController.swift
//  flixster
//
//  Created by kin on 5/5/19.
//  Copyright © 2019 Kin. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    var movie: [String:Any]!
    var trailerData = [[String:Any]]()
    var trailerKeys = [String:Any]()
    var trailerKey: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let movieID = movie["id"] as! Int
        let videoUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: videoUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.trailerData = dataDictionary["results"] as! [[String:Any]]
                self.trailerData = [self.trailerData[0]]
                self.trailerKeys = self.trailerData[0]
                self.trailerKey = self.trailerKeys["key"] as? String
                print(self.trailerKey!)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                let youtubeURL = "https://www.youtube.com/watch?v="
                let trailerURL = URL(string: youtubeURL + self.trailerKey!)
                self.webView.load(URLRequest(url: trailerURL!))
            }
            
        }
        task.resume()
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
