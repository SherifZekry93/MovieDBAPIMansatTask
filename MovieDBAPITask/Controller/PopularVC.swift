//
//  ViewController.swift
//  MovieDBAPITask
//
//  Created by Sherif  Wagih on 4/2/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
class PopularVC: UITableViewController {
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    var allActors = [Actor]()
    var totalResults:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getAllActors()
    }
    
    internal func getAllActors()
    {
        //I tried using params which is an arrya of dictionaries but looks like there is something wrong with the api.
        ProgressHUD.show(currentPage == 1 ? "Loading Actors": "Loading More Actors")
        let full_URL = "https://api.themoviedb.org/3/person/popular?api_key=f06aa1ea5b88c7c955da135b83bb6ef0&language=en-US&page=\(currentPage)"
        Alamofire.request(full_URL, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error != nil
            {
                ProgressHUD.showError("\(response.result.error!.localizedDescription)")
                return
            }
            if let data = response.data
            {
                let actorRoot = try! JSONDecoder().decode(ActorRoot.self, from: data)
                if let results = actorRoot.total_results
                {
                    self.totalResults = results
                }
                actorRoot.results?.forEach({ (actor) in
                    self.allActors.append(actor)
                    let index = self.allActors.firstIndex{$0 === actor}
                    let path = IndexPath(item: index!, section: 0)
                    self.tableView.insertRows(at: [path], with: .automatic)
                })
                ProgressHUD.dismiss()
            }
        }
    }
   
}
