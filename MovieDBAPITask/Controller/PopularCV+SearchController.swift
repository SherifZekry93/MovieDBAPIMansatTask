//
//  PopularCV+SearchController.swift
//  MovieDBApiTask
//
//  Created by Sherif  Wagih on 4/4/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import ProgressHUD
extension PopularVC:UISearchBarDelegate
{
    internal func setupSerachBar()
    {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !Connectivity.isConnectedToInternet
        {
            ProgressHUD.showError("You are not connected to the internet.")
            return
        }
        if let text = searchBar.text, text != ""
        {
            filteredActors.removeAll()
//            tableView.scrollsToTop = true
            searchAllActors(searchText: text)
        }
        else
        {
            refreshSearchData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshSearchData()
    }
    fileprivate func refreshSearchData()
    {
//        tableView.scrollsToTop = true
        self.searchController.isActive = false
        filteredActors.removeAll()
        self.tableView.reloadData()
    }
}
