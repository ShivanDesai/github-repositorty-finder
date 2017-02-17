//
//  SettingsDelegate.swift
//  GithubDemo
//
//  Created by Shivan Desai on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation

protocol SettingsDelegate: class {
    
    func settings( _ settings: SettingsViewController, didChangeMinimumStars minimunStars: Int?)
    
    
}
