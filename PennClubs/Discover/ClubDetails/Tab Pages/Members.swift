//
//  Members.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 10/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit

class Members : UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var memberTableView = UITableView()
    var members : [MemberData] = []
    let memberCellId = "memberCellId"
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        setMemberTableView()
    }
    
    func setMemberTableView() {
        view.addSubview(memberTableView)
        setMemberTableViewDelegate()
        memberTableView.rowHeight = 100
        memberTableView.translatesAutoresizingMaskIntoConstraints = false
        memberTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        memberTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        memberTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func setMemberTableViewDelegate() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
        
        memberTableView.register(UITableViewCell.self, forCellReuseIdentifier: memberCellId)
    }
    
    func getClubData(input clubCode:String) {
        let jsonUrlString = "https://api.pennclubs.com/clubs/" + clubCode + "/members/"

            let url = URL(string: jsonUrlString)
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                do {
                    defer {
                        DispatchQueue.main.async {
//                            self.clubs.shuffle()
                            self.memberTableView.reloadData()
                            print("done")
//                            self.refreshControl.endRefreshing()
                        }
                    }
                    
                    guard let data = data else { print("error at data = data"); return }
                    let clubsDecoded = try JSONDecoder().decode([MemberData].self, from: data)
                    self.members = clubsDecoded
                } catch let jsonErr {
                    print("JSON Serialization Error", jsonErr)
                }
            }.resume()
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberTableView.dequeueReusableCell(withIdentifier: memberCellId, for: indexPath)
        print(members[indexPath.item].name)
        cell.backgroundColor = .white
        return cell
    }
}

class MemberCell : UITableViewCell {
    
}
