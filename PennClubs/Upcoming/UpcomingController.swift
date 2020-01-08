//
//  File.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 24/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import Foundation
import UIKit
import EventKitUI

class UpcomingController : UIViewController {
    
    
//    private var calendar = EKCalendar(for: .event, eventStore: .init())
    let calendar = Calendar.current
    let rightNow = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        print(calendar)
    }
    
}
