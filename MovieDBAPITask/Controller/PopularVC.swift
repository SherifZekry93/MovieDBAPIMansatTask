//
//  ViewController.swift
//  MovieDBAPITask
//
//  Created by Sherif  Wagih on 4/2/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import Alamofire
class PopularVC: UITableViewController {
    var page:Int = 1
    var allActors = [Actor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getAllActors()
        
    }
    
    fileprivate func setupTableView()
    {
        tableView.backgroundColor = .black
        tableView.register(ActorCell.self, forCellReuseIdentifier: CellIDS.actorCell.rawValue)
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.actorCell.rawValue, for: indexPath) as! ActorCell
        cell.configureCell(actor: allActors[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allActors.count
    }
    fileprivate func getAllActors()
    {
        
        let full_URL = "https://api.themoviedb.org/3/person/popular?api_key=f06aa1ea5b88c7c955da135b83bb6ef0&language=en-US&page=\(page)"
        Alamofire.request(full_URL, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.data
            {
                let actorRoot = try! JSONDecoder().decode(ActorRoot.self, from: data)
                self.allActors = actorRoot.results
                self.tableView.reloadData()
            }
        }
    }
}
