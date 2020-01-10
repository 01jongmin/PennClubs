//
//  ViewController.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 17/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import UIKit

class DiscoverController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchControllerDelegate {
    
    var clubs = [ClubData]()
    var filteredClubs = [ClubData]()
    
    var bookmarkedClubCodeArray = Set<String>()
    
    var isSearching = false
    var isFiltering = false
    
    private let refreshControl = UIRefreshControl()
    
    let wifiErrorNotifyLabel = UIButton()
    
    func getClubData() {
        let jsonUrlString = "https://api.pennclubs.com/clubs/"

        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
//            if err != nil{
//                print("Error \(String(describing: err))")
//                return
//            }
            
            do {
                defer {
                    DispatchQueue.main.async {
                        self.clubs.shuffle()
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                }
                
                guard let data = data else { print("error at data = data"); return }
                let clubsDecoded = try JSONDecoder().decode([ClubData].self, from: data)
                self.clubs = clubsDecoded
            } catch let jsonErr {
                print("JSON Serialization Error", jsonErr)
            }
        }.resume()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterImage = UIImage(systemName: "line.horizontal.3.decrease.circle")!
    var filterImageClicked = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")!
    let discoverModeSwitch = UIButton()
    
    
    let x = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshController()
        
        collectionView.backgroundColor = UIColor.white
        view.addSubview(searchController.searchBar)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(filterImage, for: .bookmark, state: .normal)
        navigationItem.searchController = searchController
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.searchTextField.widthAnchor.constraint(equalToConstant: searchController.searchBar.bounds.width * 0.70).isActive = true
        searchController.searchBar.searchTextField.leftAnchor.constraint(equalTo: searchController.searchBar.leftAnchor, constant: searchController.searchBar.bounds.width * 0.05 ).isActive = true
        searchController.searchBar.searchTextField.centerYAnchor.constraint(equalTo: searchController.searchBar.centerYAnchor).isActive = true
        searchController.searchBar.layoutIfNeeded()
        
        discoverModeSwitch.layer.cornerRadius = 10
        discoverModeSwitch.backgroundColor = UIColor(red:0.38, green:0.72, blue:0.95, alpha:1.0)
        
       let switchImage = UIImage(systemName: "arrow.2.circlepath.circle")
                
        searchController.searchBar.addSubview(discoverModeSwitch)
        discoverModeSwitch.setImage(switchImage, for: .normal)
        discoverModeSwitch.tintColor = .white
        discoverModeSwitch.setTitle(" Events", for: .normal)
        discoverModeSwitch.titleLabel?.font = UIFont(name: "Avenir-Black", size: UIFont.systemFontSize)
        
        
        discoverModeSwitch.translatesAutoresizingMaskIntoConstraints = false

        discoverModeSwitch.leftAnchor.constraint(equalToSystemSpacingAfter: searchController.searchBar.searchTextField.rightAnchor, multiplier: 1.0).isActive = true
        discoverModeSwitch.rightAnchor.constraint(equalTo: searchController.searchBar.rightAnchor, constant: -searchController.searchBar.bounds.width * 0.05).isActive = true
        discoverModeSwitch.heightAnchor.constraint(equalTo: searchController.searchBar.searchTextField.heightAnchor).isActive = true
        discoverModeSwitch.centerYAnchor.constraint(equalTo: searchController.searchBar.searchTextField.centerYAnchor).isActive = true
        
        searchController.searchBar.returnKeyType = .done
        searchController.obscuresBackgroundDuringPresentation = false
        
        getClubData()
        collectionView?.register(ClubCell.self, forCellWithReuseIdentifier: "cellID")
        view.layoutIfNeeded()
    
        discoverModeSwitch.layoutIfNeeded()
        discoverModeSwitch.layer.shadowOffset = .zero
        discoverModeSwitch.layer.shadowColor = UIColor(red:0.15, green:0.40, blue:0.57, alpha:1.0).cgColor
        discoverModeSwitch.layer.shadowRadius = 4
        discoverModeSwitch.layer.shadowOpacity = 0.5
        discoverModeSwitch.layer.shadowPath = UIBezierPath(rect: discoverModeSwitch.bounds).cgPath
//
//        let maskView = UIView()
//        view.addSubview(maskView)
//        maskView.translatesAutoresizingMaskIntoConstraints = false
//        maskView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        maskView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
//        maskView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        maskView.clipsToBounds = true
//
//        wifiErrorNotifyLabel.backgroundColor = .red
//        wifiErrorNotifyLabel.setTitle("Test", for: .normal)
//        wifiErrorNotifyLabel.addTarget(self, action: #selector(testFunc), for: .touchUpInside)
//        maskView.addSubview(wifiErrorNotifyLabel)
//
//        wifiErrorNotifyLabel.translatesAutoresizingMaskIntoConstraints = false
//        wifiErrorNotifyLabel.widthAnchor.constraint(equalTo: maskView.widthAnchor).isActive = true
//        wifiErrorNotifyLabel.heightAnchor.constraint(equalTo: maskView.heightAnchor, multiplier: 0.10).isActive = true
//        wifiErrorNotifyLabel.topAnchor.constraint(equalTo: maskView.topAnchor, constant: 0).isActive = true
//
//        wifiErrorNotifyLabel.mask = maskView
        
    }
    
    @objc func testFunc() {
        print("touched Something")
    }
    
    func configureRefreshController() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshClubData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshClubData(_ sender: Any) {
        getClubData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        if (isFiltering) {
            searchController.searchBar.setImage(filterImage, for: .bookmark, state: .normal)
            isFiltering = false
        } else {
            searchController.searchBar.setImage(filterImageClicked, for: .bookmark, state: .normal)
            isFiltering = true
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredClubs.count
        } else {
         return clubs.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        var club: ClubData
        
        if isSearching {
            club = filteredClubs[indexPath.item]
        } else {
            club = clubs[indexPath.item]
        }
        
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ClubCell
        cell.set(clubData: club, clubDetailPageNavigation: moveToClubDetailsPage(inputClubData: ))
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.showsBookmarkButton = false
        isFiltering = false
        discoverModeSwitch.isHidden = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.showsBookmarkButton = true
        discoverModeSwitch.isHidden = false
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        isSearching = false
        view.endEditing(true)
        clubs.shuffle()
        self.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchController.searchBar.text == nil || searchController.searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            isSearching = true
            filteredClubs = clubs.filter({$0.name.range(of: searchController.searchBar.text!, options: .caseInsensitive) != nil || $0.description?.range(of: searchController.searchBar.text!, options: .caseInsensitive) != nil })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            // called right after rotation transition ends
            self.view.setNeedsLayout()
        })
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 10, height: 200)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.width
            layout.itemSize = CGSize(width: width, height: 200)
            layout.invalidateLayout()
        }
    }
    
//    func configureFade() {
//        let fadeMask = CAGradientLayer()
//        view.layer.addSublayer(fadeMask)
//        fadeMask.frame = CGRect(x: 0, y: searchController.searchBar.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height - (self.tabBarController?.tabBar.frame.height ?? 0))
//       fadeMask.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
//
//        fadeMask.locations = [0.05, 0.10, 0.85, 0.93]
//    }
    
    func bookmarkClubWithCode(code: String) {
        bookmarkedClubCodeArray.insert(code)
        print(bookmarkedClubCodeArray)
    }
    
    func moveToClubDetailsPage(inputClubData: ClubData) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let clubDetailsView = ClubDetails(collectionViewLayout: layout)
        clubDetailsView.set(clubData: inputClubData)
        clubDetailsView.title = inputClubData.name
        print("something")
        self.navigationController?.pushViewController(clubDetailsView, animated: true)
    }
    
    
    
}

