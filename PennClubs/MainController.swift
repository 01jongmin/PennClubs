//
//  MainController.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 24/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import Foundation
import UIKit

class MainController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        
        self.navigationController?.isNavigationBarHidden = false
        selectedIndex = 2
    }
    
    func configureViewControllers() {
        let discover = UINavigationController(rootViewController: DiscoverController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        discover.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        discover.tabBarItem.title = "Discover"
        
        let upcoming = UINavigationController(rootViewController: UpcomingController())
        upcoming.tabBarItem.image = UIImage(systemName: "calendar")
        upcoming.tabBarItem.title = "Upcoming"
        
        let manage = UINavigationController(rootViewController: ManageController())
        manage.tabBarItem.image = UIImage(systemName: "doc.plaintext")
        manage.tabBarItem.title = "Manage"
        
        viewControllers = [manage, upcoming, discover]
    }
    
}
