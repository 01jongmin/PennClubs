//
//  ClubDetails.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 7/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit
import Kingfisher

class ClubDetails: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let clubName = UILabel()
    var clubImage : ImageResource? = nil
    let imageWrapper = UIView()
    var clubImageView = UIImageView()
    var clubCode : String = ""
    
    var yesClubImageConstraint = NSLayoutConstraint()
    var noClubImageConstraint = NSLayoutConstraint()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    
    func set(clubData: ClubData) {
        configureImageWrapper()
        setUpImageWrapperConstraints()
        configureClubImageView(input: clubData)
        setupMenuBar()
        configureCollectionView()
        clubCode = clubData.code
        (viewArray[2] as! Members).getClubData(input: clubCode)
    }
    
    func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func configureImageWrapper() {
        view.addSubview(imageWrapper)
        imageWrapper.translatesAutoresizingMaskIntoConstraints = false
        imageWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageWrapper.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }

    func setUpImageWrapperConstraints() {
        noClubImageConstraint = imageWrapper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        yesClubImageConstraint = imageWrapper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40)
    }
    
    func configureClubImageView(input clubData: ClubData) {
        
        if let imageUrlString = clubData.image_url {
            clubImage = ImageResource(downloadURL: URL(string: imageUrlString)!, cacheKey: imageUrlString)
            imageWrapper.addSubview(clubImageView)
            clubImageView.kf.setImage(with: clubImage)

            yesClubImageConstraint.isActive = true
            
            clubImageView.contentMode = UIView.ContentMode.scaleAspectFit
            clubImageView.translatesAutoresizingMaskIntoConstraints = false
            clubImageView.updateConstraints()
            clubImageView.heightAnchor.constraint(equalTo: imageWrapper.heightAnchor, multiplier: 8/10).isActive = true
            clubImageView.leadingAnchor.constraint(equalTo: imageWrapper.leadingAnchor, constant: 10).isActive = true
            clubImageView.trailingAnchor.constraint(equalTo: imageWrapper.trailingAnchor, constant: -10).isActive = true
            clubImageView.centerYAnchor.constraint(equalTo: imageWrapper.centerYAnchor).isActive = true
        } else {
            noClubImageConstraint.isActive = true
        }
    }
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.clubDetails = self
       return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        menuBar.topAnchor.constraint(equalTo: imageWrapper.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: view.frame.height * 0.06).isActive = true
        
        menuBar.layoutIfNeeded()
        
        menuBar.layer.addBorder(edge: .top, color: .lightGray, thickness: 1.0)
        menuBar.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    let viewArray = [Details(), Events(), Members()]
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        var view = UIView()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        for subview in cell.subviews {
            subview.removeFromSuperview()
            print("removed subview")
        }
    
        let viewer = viewArray[indexPath.item].view
        
        cell.addSubview(viewer!)
        print("added subview")
        
//        if indexPath.item == 0 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath)
//            cell.addSubview(viewArray[indexPath.item].view)
//        } else if indexPath.item == 1 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath)
//            cell.addSubview(viewArray[indexPath.item].view)
//        } else {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath)
//            cell.addSubview(viewArray[indexPath.item].view)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x/view.safeAreaLayoutGuide.layoutFrame.width
        
        let indexPath = IndexPath(item: Int(targetIndex), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

extension CALayer {

  func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case .top:
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        break
    case .bottom:
        border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
        break
    case .left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
        break
    case .right:
        border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
        break
    default:
        break
    }

    border.backgroundColor = color.cgColor;
    
    addSublayer(border)
  }
}
