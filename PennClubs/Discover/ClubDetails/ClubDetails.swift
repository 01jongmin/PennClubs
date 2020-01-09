//
//  ClubDetails.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 7/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit
import Kingfisher

class ClubDetails: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let clubName = UILabel()
    var clubImage : ImageResource? = nil
    let imageWrapper = UIView()
    var clubImageView = UIImageView()
    
    var yesClubImageConstraint = NSLayoutConstraint()
    var noClubImageConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func set(clubData: ClubData) {
        configureImageWrapper()
        setUpImageWrapperConstraints()
        configureClubImageView(input: clubData)
        setupMenuBar()
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
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
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
