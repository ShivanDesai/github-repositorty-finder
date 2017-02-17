//
//  ViewController.swift
//  GithubDemo
//
//  Created by Shivan Desai on 2/16/17.
//  Copyright (c) 2017 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the UITableView
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 300
        //tableView.rowHeight = UITableViewAutomaticDimension

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            self.repos = newRepos
            // Print the returned repositories to the output window
            for repo in newRepos {
               // print(repo)
            }
            
            self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if((self.repos) != nil){
            return self.repos.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        
        cell.descriptionLabel.text = self.repos[indexPath.row].repoDescription
        cell.nameLabel.text = self.repos[indexPath.row].name
        cell.starLabel.text = "\(self.repos[indexPath.row].stars!)"
        cell.forkLabel.text = "\(self.repos[indexPath.row].forks!)"
        let avatarURL = URL(string: self.repos[indexPath.row].ownerAvatarURL!)
        cell.ownerImageView.setImageWith(avatarURL!)
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let settingsVC = nav.topViewController as! SettingsViewController
            settingsVC.searchSettings = self.searchSettings
            settingsVC.delegate = self
                
    }
    
    func settings( _ settings: SettingsViewController, didChangeMinimumStars minimunStars: Int?){

        if let stars = minimunStars {
            self.searchSettings.minStars = stars
            NSLog("stars =  \(self.searchSettings.minStars)")
            //reload data
            doSearch()

        }
    }

}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
