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
        let label = UILabel()
        label.text = titles[section]
        
        label.backgroundColor = .white
        return label
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
        
//        var organizeCounter = 0
        
//        print(twoDimensional)
        
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

class MemberCell : UITableViewCell {
    
    let memberNameLabel = UILabel()
    let memberTitleLabel = UILabel()
    
    let imageWrapper = UIView()
    let descriptionWrapper = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        configureImageWrapper()
        configureDescriptionWrapper()
    }
    
    func configureImageWrapper() {
        addSubview(imageWrapper)
        
        imageWrapper.backgroundColor = .lightGray
        
        imageWrapper.translatesAutoresizingMaskIntoConstraints = false
        imageWrapper.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2.0).isActive = true
        imageWrapper.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70).isActive = true
        imageWrapper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageWrapper.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70).isActive = true
    }
    
    func configureDescriptionWrapper() {
        addSubview(descriptionWrapper)
        
        descriptionWrapper.translatesAutoresizingMaskIntoConstraints = false
        descriptionWrapper.leftAnchor.constraint(equalTo: imageWrapper.rightAnchor).isActive = true
        descriptionWrapper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        descriptionWrapper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionWrapper.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70).isActive = true
    }
    
    func set(member: MemberData) {
        
        addSubview(memberNameLabel)
        memberNameLabel.numberOfLines = 1
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        memberNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: descriptionWrapper.leftAnchor, multiplier: 2.0).isActive = true
        memberNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.70).isActive = true
        memberNameLabel.heightAnchor.constraint(equalTo: descriptionWrapper.heightAnchor, multiplier: 0.60).isActive = true
        memberNameLabel.topAnchor.constraint(equalTo: descriptionWrapper.topAnchor).isActive = true
        
        memberNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        memberNameLabel.text = member.name
        memberNameLabel.adjustsFontSizeToFitWidth = true
        memberNameLabel.backgroundColor = .white
        
        addSubview(memberTitleLabel)
        memberTitleLabel.numberOfLines = 1
        memberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        memberTitleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: descriptionWrapper.leftAnchor, multiplier: 2.0).isActive = true
        memberTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.70).isActive = true
        memberTitleLabel.heightAnchor.constraint(equalTo: descriptionWrapper.heightAnchor, multiplier: 0.40).isActive = true
        memberTitleLabel.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor).isActive = true
        
        memberTitleLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        memberTitleLabel.text = member.title
        memberTitleLabel.textColor = .darkGray
        memberTitleLabel.adjustsFontSizeToFitWidth = true
        memberTitleLabel.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
