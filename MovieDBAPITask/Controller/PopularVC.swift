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
    
    var currentActorPage : Int = 1
    var currentSearchPage:Int = 1
    var isLoadingList : Bool = false
    var allActors = [Actor]()
    var totalResults:Int = 0
    var filteredActors:[Actor] = [Actor]()
    let searchController = UISearchController(searchResultsController: nil)
    var totalSearchResults = 1
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        getAllActors()
        setupNavigationBar()
        setupSerachBar()
    }
    
    internal func getAllActors()
    {
        if !Connectivity.isConnectedToInternet
        {
            ProgressHUD.showError("You are not connected to the internet")
            return
        }
        else
        {
            //I tried using params which is a dictionary that can be sent with alamofire but looks like there is something wrong with the api.
            //or probably something wrong with my code :D
            ProgressHUD.show(currentActorPage == 1 ? "Loading Actors": "Loading More Actors")
            let full_URL = "https://api.themoviedb.org/3/person/popular?api_key=f06aa1ea5b88c7c955da135b83bb6ef0&language=en-US&page=\(currentActorPage)"
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
                        self.totalSearchResults = results
                    }
                    actorRoot.results?.forEach({ (actor) in
                        print(actor)
                        self.allActors.append(actor)
                        self.tableView.reloadData()
                    })
                    ProgressHUD.dismiss()
                }
            }

        }
    }
    
    internal func searchAllActors(searchText:String)
    {
        if !Connectivity.isConnectedToInternet
        {
            ProgressHUD.showError("You are not connected to the internet")
        }
        else
        {
            //I tried using params which is a dictionary that can be sent with alamofire but looks like there is something wrong with the api.
            //or probably something wrong with my code :D
            ProgressHUD.show("Loading Actors")
            let full_Search_URL = "https://api.themoviedb.org/3/search/person?api_key=f06aa1ea5b88c7c955da135b83bb6ef0&language=en-US&query=\(searchText)&page=\(currentSearchPage)&include_adult=false"
            Alamofire.request(full_Search_URL, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
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
                        if self.totalResults == 0
                        {
                            ProgressHUD.showError("No actors to display!")
                            return
                        }
                    }
                    actorRoot.results?.forEach({ (actor) in
                        self.filteredActors.append(actor)
                        self.tableView.reloadData()
                    })
                    ProgressHUD.dismiss()
                }
            }
            
        }
    }
    
    
    fileprivate func setupNavigationBar()
    {
        navigationItem.title = "All Actors";
        navigationController?.navigationBar.isTranslucent = false
    }
   
}
