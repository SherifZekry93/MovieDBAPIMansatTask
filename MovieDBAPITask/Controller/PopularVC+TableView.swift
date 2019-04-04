//
//  PopularVC+TableView.swift
//  MovieDBApiTask
//
//  Created by Sherif  Wagih on 4/3/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
extension PopularVC
{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIDS.actorCell.rawValue, for: indexPath) as! ActorCell
        print(filteredActors.count)
        searchController.isActive ?  cell.configureCell(actor: filteredActors[indexPath.row]) :  cell.configureCell(actor: allActors[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive == true
        {
            return filteredActors.count
        }
        else
        {
            return allActors.count

        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.isActive == true
        {
            if indexPath.row == filteredActors.count - 1 && indexPath.row != totalSearchResults - 1
            {
                currentSearchPage += 1
                if let text = searchController.searchBar.text
                {
                    searchAllActors(searchText: text)
                }
            }
        }
        else
        {
            if indexPath.row == allActors.count - 1 && indexPath.row != totalResults - 1
            {
                currentActorPage += 1
                getAllActors()
            }
        }
    }
    internal func setupTableView()
    {
        tableView.backgroundColor = .black
        tableView.register(ActorCell.self, forCellReuseIdentifier: CellIDS.actorCell.rawValue)
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
}
