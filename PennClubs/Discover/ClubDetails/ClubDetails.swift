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

    let clubNameLabel = UILabel()
    var clubImage : ImageResource? = nil
    let imageWrapper = UIView()
    var clubImageView = UIImageView()
    
    var yesClubImageConstraint = NSLayoutConstraint()
    var noClubImageConstraint = NSLayoutConstraint()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func set(clubData: ClubData) {
        configureImageWrapper()
        setUpImageWrapperConstraints()
        configureClubImageView(input: clubData.image_url)
        configureClubNameLabel(input: clubData.name)
        setupMenuBar()
        configureCollectionView()
        (viewArray[0] as! Details).getClubData(input: clubData.code)
        (viewArray[2] as! Members).getClubData(input: clubData.code)
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
        imageWrapper.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }

    func setUpImageWrapperConstraints() {
        noClubImageConstraint = imageWrapper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        yesClubImageConstraint = imageWrapper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50)
    }

    func configureClubImageView(input clubDataImageUrl: String?) {

        if let imageUrlString = clubDataImageUrl {
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

    func configureClubNameLabel(input clubName: String) {
        view.addSubview(clubNameLabel)
        clubNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        clubNameLabel.backgroundColor = .blue
        clubNameLabel.heightAnchor.constraint(equalTo: imageWrapper.heightAnchor, multiplier: 0.6).isActive = true
        clubNameLabel.leftAnchor.constraint(equalTo: imageWrapper.rightAnchor).isActive = true
        clubNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        clubNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageWrapper.topAnchor, multiplier: 2.0).isActive = true
        clubNameLabel.text = clubName

        clubNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        clubNameLabel.adjustsFontSizeToFitWidth = true
        clubNameLabel.numberOfLines = 2
//        clubImageView.centerYAnchor.constraint(equalTo: imageWrapper.centerYAnchor).isActive = true
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        for subview in cell.subviews {
            subview.removeFromSuperview()
        }

        let tabView = viewArray[indexPath.item].view

        cell.addSubview(tabView!)

        tabView?.translatesAutoresizingMaskIntoConstraints = false
        tabView?.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        tabView?.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        tabView?.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        tabView?.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true

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
