//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Shivan Desai on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    let tableStructure: [[String]] = [["Minium Stars"]]
    
    
    var searchSettings = GithubRepoSearchSettings()
    //copy of settings
    var minimumStars : Int = 0
    
    weak var delegate: SettingsDelegate?
    
    @IBAction func cancelSettings(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSettings(_ sender: AnyObject) {
        delegate?.settings(self, didChangeMinimumStars: self.minimumStars)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //set the slide value
        self.minimumStars = self.searchSettings.minStars
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        if(indexPath.section == 0){
            let prefIdentifier = tableStructure[indexPath.section][indexPath.row]
            cell.preIdentifierLabel.text = prefIdentifier
            cell.minimunStarSlider.value = Float(self.searchSettings.minStars)
            cell.minimunStarSlider.minimumValue = 0
            cell.minimunStarSlider.maximumValue = 100000
            cell.minimunStarSlider.addTarget(self, action: #selector(SettingsViewController.sliderChange(_:)), for: .valueChanged)
        }
   // cell.delegate = self
    return cell
    
    }
    
    // get slider's value
    func sliderChange(_ sender: UISlider) {
        let currentValue = sender.value
        self.minimumStars = Int(currentValue)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
