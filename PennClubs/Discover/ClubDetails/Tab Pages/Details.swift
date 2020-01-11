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
    
    var detailsTableView = UITableView()
    let cellId = "cellId"
    var clubDetailsData : ClubDetailsData? = nil
    
    let sectionContent = [[String]]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(detailsTableView)
        
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        
        detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        detailsTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive = true
        detailsTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0).isActive = true
        detailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    func getClubData(input clubCode: String) {
        let jsonUrlString = "https://api.pennclubs.com/clubs/" + clubCode + "/"

        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            do {
                defer {
                    DispatchQueue.main.async {
                        self.sortClubDetailsData()
                        self.detailsTableView.reloadData()
                    }
                }
                
                guard let data = data else { print("error at data = data"); return }
                let clubsDecoded = try JSONDecoder().decode(ClubDetailsData.self, from: data)
                self.clubDetailsData = clubsDecoded
            } catch let jsonErr {
                print("JSON Serialization Error", jsonErr)
            }
        }.resume()
    }
    
    func sortClubDetailsData() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sectionTitles[section]
        label.backgroundColor = .white

        return label
    }
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
    
    let tester = [["We are a team of student software engineers, product designers, and business developers. Our ultimate goal is improving the Penn community with technology. In addition to creating 100% free high-quality products, we give back with educational resources and technical support."], ["20 - 50 Members", "Not Currently Accepting Members", "Application Required for All Roles"], ["facebook.com/labsatpenn", "pennappslabs@gmail.com", "pennlabs.org", "github.com/pennlabs"]]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let x = UITextView()
        x.text = tester[indexPath.section][indexPath.row]
        
        if (indexPath.section == 0) {
            x.font = UIFont(name: "HelveticaNeue", size: 20)
        } else{
            x.font = UIFont(name: "HelveticaNeue", size: 10)
        }
        
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
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
