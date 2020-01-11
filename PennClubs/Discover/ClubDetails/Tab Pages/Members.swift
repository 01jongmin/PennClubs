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
    var memberDictionary : Dictionary<String, [MemberData]> = Dictionary<String, [MemberData]>()
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        setMemberTableView()
    }
    
    func setMemberTableView() {
        view.addSubview(memberTableView)
        memberTableView.allowsSelection = false
        memberTableView.backgroundColor = .white
        setMemberTableViewDelegate()
        memberTableView.rowHeight = 70
        memberTableView.translatesAutoresizingMaskIntoConstraints = false
        memberTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        memberTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        memberTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func setMemberTableViewDelegate() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
        
        memberTableView.register(MemberCell.self, forCellReuseIdentifier: memberCellId)
    }
    
    func getClubData(input clubCode:String) {
        let jsonUrlString = "https://api.pennclubs.com/clubs/" + clubCode + "/members/"

            let url = URL(string: jsonUrlString)
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                do {
                    defer {
                        DispatchQueue.main.async {
                            self.sortUsers()
                            self.memberTableView.reloadData()
//                            print(self.memberDictionary.count)
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
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return Array(memberDictionary.keys)
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
//
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: tableView.frame.height * 0.10)
        sectionHeaderView.addSubview(blurredEffectView)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: tableView.frame.height * 0.10)
        label.text = "   " + titles[section]
        label.textColor = .black
        sectionHeaderView.addSubview(label)
//        print()
        
//        label.backgroundColor = .white
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.height * 0.10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    var twoDimensional = [[MemberData]]()
    var titles = [String]()
    
    func sortUsers() {
        for member in members {
            memberDictionary.updateValue((memberDictionary[member.title] ?? []) + [member], forKey: member.title)
        }
        
        titles = [String](repeating: "", count: memberDictionary.count)
        twoDimensional = [[MemberData]](repeating: [MemberData](), count: memberDictionary.count)
        
        var counter = 0
        
        for key in memberDictionary.keys {
            titles[counter] = key
            twoDimensional[counter] = memberDictionary[key]!
            counter = counter + 1
        }
        
        var positionCounter = 0
        
        if let position = titles.firstIndex(of: "Owner") {
            titles.swapAt(positionCounter, position)
            twoDimensional.swapAt(positionCounter, position)
            positionCounter = positionCounter + 1
        }
        
        if let position = titles.firstIndex(of: "Co-Director") {
            titles.swapAt(positionCounter, position)
            twoDimensional.swapAt(positionCounter, position)
            positionCounter = positionCounter + 1
        }
        
        if let position = titles.firstIndex(of: "Team Lead") {
            titles.swapAt(positionCounter, position)
            twoDimensional.swapAt(positionCounter, position)
            positionCounter = positionCounter + 1
        }
        
        if let position = titles.firstIndex(of: "Marketing & Content Strategy") {
            titles.swapAt(positionCounter, position)
            twoDimensional.swapAt(positionCounter, position)
            positionCounter = positionCounter + 1
        }
        
        if let position = titles.firstIndex(of: "Member") {
            titles.swapAt(positionCounter, position)
            twoDimensional.swapAt(positionCounter, position)
            positionCounter = positionCounter + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensional[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberTableView.dequeueReusableCell(withIdentifier: memberCellId) as! MemberCell
        cell.set(member: twoDimensional[indexPath.section][indexPath.row])
        return cell
    }
}
