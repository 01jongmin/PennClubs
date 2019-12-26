//
//  Test.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 24/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import Foundation
import UIKit

class Test : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = UIView()
        test.backgroundColor = .black
        view.addSubview(test)
        test.translatesAutoresizingMaskIntoConstraints = false
//        test.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        test.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
}
