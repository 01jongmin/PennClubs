//
//  Details.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 10/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit
import WebKit
//import FontAwesome_swift

class Details : UIViewController, UITableViewDelegate, UITableViewDataSource, WKUIDelegate {
    
    var sectionTitles = ["Description", "Basic Info", "Social"]
    
    var detailsTableView = UITableView()
    let cellId = "cellId"
    var clubDetailsData : ClubDetailsData? = nil
    
    var sectionContent : [[String]] = [[],[],[]]
    
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
        
        detailsTableView.allowsSelection = false
    }
    
    func getClubData(input clubCode: String) {
        let jsonUrlString = "https://pennclubs.com/api/clubs/" + clubCode + "/"

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
        sectionContent[0] = [(clubDetailsData?.description ?? "")]
        sectionContent[1] = [typeToSizeDescription(type: clubDetailsData?.size ?? 0),
                             boolToAcceptingApplicationDescription(accepting: clubDetailsData?.accepting_members ?? false),
                             typeToApplicationRequiredDescription(type: clubDetailsData?.application_required ?? 0)]

        var social : [String] = []
        
        if let facebookString = clubDetailsData?.facebook {
            if (!facebookString.isEmpty) {
                social = social + [facebookString]
            }
        }
        
        if let emailString = clubDetailsData?.email {
            if (!emailString.isEmpty) {
                social = social + [emailString]
            }
        }
        
        if let twitterString = clubDetailsData?.twitter {
            if (!twitterString.isEmpty) {
                social = social + [twitterString]
            }
        }
        
        if let instagramString = clubDetailsData?.instagram {
            if (!instagramString.isEmpty) {
                social = social + [instagramString]
            }
        }
        
        if let linkedInString = clubDetailsData?.linkedin {
            if (!linkedInString.isEmpty) {
                social = social + [linkedInString]
            }
        }
        
        if let githubString = clubDetailsData?.github {
            if (!githubString.isEmpty) {
                social = social + [githubString]
            }
        }
        
        if let websiteString = clubDetailsData?.website {
            if (!websiteString.isEmpty) {
                social = social + [websiteString]
            }
        }
    
        sectionContent[2] = social
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 60)
        sectionHeaderView.addSubview(blurredEffectView)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 60)
        label.text = "   " + sectionTitles[section]
            
        label.textColor = .black
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sectionContent[0].count
        } else if section == 1 {
            return sectionContent[1].count
        } else {
            return sectionContent[2].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.textColor = .darkGray
        cell.contentView.tintColor = .darkGray
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]

        if (indexPath.section == 0) {
            if (sectionContent[0][0] == "") {
                cell.textLabel?.text = "This club has not added a description yet."
            } else {
                cell.textLabel?.text = nil
                let webView1 = WKWebView()
//                cell.webView.delegate = self
                webView1.uiDelegate = self
                webView1.loadHTMLString(sectionContent[0][0], baseURL: nil)
                webView1.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
//                webView1.translatesAutoresizingMaskIntoConstraints = false
//                webView1.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1.0).isActive = true
//                webView1.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1.0).isActive = true
            }

        }

        if (indexPath.section == 1) {
            if (indexPath.item == 0) {
                cell.imageView?.image = UIImage(systemName: "person")?.withTintColor(.red)
            } else if (indexPath.item == 1) {
                if (clubDetailsData?.accepting_members ?? true) {
                    cell.imageView?.image = UIImage(systemName: "checkmark.circle")
                } else {
                    cell.imageView?.image = UIImage(systemName: "xmark.circle")
                }
            } else if (indexPath.item == 2) {
                cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
        } else {
            cell.imageView?.image = nil
        }

        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    
    func typeToApplicationRequiredDescription(type : Int) -> String {
        
//        let icon = UIImage(systemName: "test")
       switch type {
           case 1:
               return " Apps for No Roles "
           case 2:
               return " Apps for Some Roles "
           case 3:
               return " Application Required for All Roles "
           default:
               return " N/A "
           }
       }
       
   func typeToSizeDescription(type : Int) -> String {
       switch type {
       case 1:
           return "< 20"
       case 2:
           return " 20 - 50 "
       case 3:
           return " 50 - 100 "
       case 4:
           return "> 100"
       default:
           return "N/A"
       }
   }
    
    func boolToAcceptingApplicationDescription(accepting: Bool) -> String {
        if accepting {
            return " Currently Accepting Members"
        } else {
            return " Not Currently Accepting Members"
        }
    }

}


//extension Data {
//    var html2AttributedString: NSAttributedString? {
//        do {
//            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            print("error:", error)
//            return  nil
//        }
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//}
//
//extension String {
//    var html2AttributedString: NSAttributedString? {
//        return Data(utf8).html2AttributedString
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//}
