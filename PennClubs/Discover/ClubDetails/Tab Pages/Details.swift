//
//  Details.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 10/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit

class Details : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionTitles = ["Description", "Basic Info", "Social"]
    
    var memberTableView = UITableView()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(memberTableView)
        
        memberTableView.dataSource = self
        memberTableView.delegate = self
        
        memberTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        memberTableView.translatesAutoresizingMaskIntoConstraints = false
        memberTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive = true
        memberTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0).isActive = true
        memberTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        memberTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = sectionTitles[section]
//        label.backgroundColor = .white
//
//        return label
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let x = UITextView()
        x.text = "asdkjasdlkgjasdlkgjasldkgjalsdjgklasdjgl asdj gklasd glkasd jglk asdklgj aslkd jglas dglka sdjglk asdjlgk asdl gasdlk gjalsdk gjlkasd gjlsad jg lalsd gasld kga sdlg asdl gasj dgla sdgjk asdlgj x"
        
        x.font = UIFont(name: "AlNile", size: 20)
        x.isEditable = false
        x.isScrollEnabled = false
        
        cell.addSubview(x)
        
        x.translatesAutoresizingMaskIntoConstraints = false
        x.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        x.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        x.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        x.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memberTableView.estimatedRowHeight = 100
        memberTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
