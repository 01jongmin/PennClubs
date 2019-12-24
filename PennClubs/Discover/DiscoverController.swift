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

    func getClubData() {
        let jsonUrlString = "https://api.pennclubs.com/clubs/"

        let url = URL(string: jsonUrlString)

        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            do {
                guard let data = data else {return }
                let clubsDecoded = try JSONDecoder().decode([ClubData].self, from: data)
                self.clubs = clubsDecoded
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let jsonErr {
                print("JSON Serialization Error", jsonErr)
                
            }
        }.resume()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterImage = UIImage(systemName: "line.horizontal.3.decrease.circle")!
    var filterImageClicked = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.white
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(filterImage, for: .bookmark, state: .normal)
        navigationItem.searchController = searchController
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .done
        searchController.obscuresBackgroundDuringPresentation = false;
        
        getClubData()
        collectionView?.register(ClubCell.self, forCellWithReuseIdentifier: "cellID")
        view.layoutIfNeeded()
        configureFade()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        if (isFiltering) {
            searchController.searchBar.setImage(filterImage, for: .bookmark, state: .normal)
            isFiltering = false
        } else {
            searchController.searchBar.setImage(filterImageClicked, for: .bookmark, state: .normal)
            isFiltering = true
        }
        
        print("clicked")
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
        
        cell.set(club: club)
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.showsBookmarkButton = false
        isFiltering = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.showsBookmarkButton = true
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
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 10, height: 10)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.width
            layout.itemSize = CGSize(width: width, height: 200)
            layout.invalidateLayout()
        }
    }
    
    func configureFade() {
        let fadeMask = CAGradientLayer()
        view.layer.addSublayer(fadeMask)
        fadeMask.frame = CGRect(x: 0, y: searchController.searchBar.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height - (self.tabBarController?.tabBar.frame.height ?? 0))
       fadeMask.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
       
        fadeMask.locations = [0.05, 0.10, 0.85, 0.93]
    }
    
    func bookmarkClubWithCode(code: String) {
        bookmarkedClubCodeArray.insert(code)
        print(bookmarkedClubCodeArray)
    }

}

