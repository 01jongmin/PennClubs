//
//  ClubDetails.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 7/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import Foundation
import UIKit

class ClubDetails: UIViewController {

    let mainView = UIView()
    let clubName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(clubName)
        
        clubName.translatesAutoresizingMaskIntoConstraints = false
        
        clubName.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        clubName.heightAnchor.constraint(equalToConstant: 100).isActive = true
        clubName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clubName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func set(clubData: ClubData) {
        clubName.text = clubData.name
        print("set")
    }
}
