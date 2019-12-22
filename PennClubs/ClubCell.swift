//
//  ClubCell.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 17/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ClubCell : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var clubImageView = UIImageView()
    private var clubNameLabel = UILabel()
    
    private var imageWrapper = UIView()
    private var descriptionWrapper = UIView()
    let iconBar = UIStackView()
    
    private var sizeLabel = UILabel()
    private var applicationRequiredLabel = UILabel()
    private var acceptingMembersLabel = UILabel()
    private var acceptingMembersIcon = UIImageView()
    private var bookMark = UIImageView()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .clear
        tagsCollection.register(tagCell.self, forCellWithReuseIdentifier: "cellID2")
        addSubview(containerView)
        configureContainerView()
        configureImageWrapper()
        configureDescriptionWrapper()
        configureIconBar()
        configureClubNameLabel()
        configureTagCellCollection()
        
        
        self.layoutIfNeeded()
        
//        DispatchQueue.main.async {
            self.tagsCollection.reloadData()
//        }
        
        configureFadeMask()
    }
    
    func typeToApplicationRequiredDescription(type : Int) -> String {
        switch type {
        case 1:
            return " Apps for No Roles "
        case 2:
            return " Apps for Some Roles "
        case 3:
            return " Apps for All Roles "
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
    
    let containerView = UIView()
    
    let cornerRadius: CGFloat = 10.0
    let xSpacing: CGFloat = 20
    let ySpacing: CGFloat = 10
    var tagArray = [Tag]()
    
    func set(club: ClubData) {
        
        if let image_url = club.image_url {
            clubImageView.sd_setImage(with: URL(string: image_url), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            clubImageView.image = UIImage(named: "CIS120")!
        }
        
        clubNameLabel.text = club.name
        
        if let sizeType = club.size {
            sizeLabel.text = typeToSizeDescription(type: sizeType)
            sizeLabel.textColor = .darkGray
        }
        
        if let applicationType = club.application_required {
            applicationRequiredLabel.text = typeToApplicationRequiredDescription(type: applicationType)
            applicationRequiredLabel.numberOfLines = 1
            applicationRequiredLabel.adjustsFontSizeToFitWidth = true
            applicationRequiredLabel.textColor = .darkGray
        }
        
        acceptingMembersLabel.numberOfLines = 1
        acceptingMembersLabel.adjustsFontSizeToFitWidth = true
        
        if club.accepting_members {
            acceptingMembersLabel.text = " Taking Members "
            acceptingMembersLabel.textColor = .darkGray
            
            acceptingMembersIcon.image = UIImage(systemName: "checkmark.circle")
            acceptingMembersIcon.tintColor = .darkGray
        } else {
            acceptingMembersLabel.text = " Not Taking Members "
            acceptingMembersLabel.textColor = .darkGray
            acceptingMembersIcon.image = UIImage(systemName: "xmark.circle")
            acceptingMembersIcon.tintColor = .darkGray
        }
        
        tagArray = club.tags
        
    
        self.tagsCollection.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContainerView() {
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
          
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.5
        let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: CGFloat(xSpacing), dy: CGFloat(ySpacing)), cornerRadius: 10)
        containerView.layer.shadowPath = shadowPath.cgPath

        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: xSpacing).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -xSpacing).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: ySpacing).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ySpacing).isActive = true
    }
    
    func configureImageWrapper() {
        containerView.addSubview(imageWrapper)
        imageWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        imageWrapper.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4/10).isActive = true
        imageWrapper.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 8/10).isActive = true
        imageWrapper.clipsToBounds = true
        imageWrapper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    
        
        imageWrapper.addSubview(clubImageView)
        clubImageView.translatesAutoresizingMaskIntoConstraints = false
        clubImageView.contentMode = UIView.ContentMode.scaleAspectFit
 
        clubImageView.heightAnchor.constraint(equalTo: imageWrapper.heightAnchor, multiplier: 8/10).isActive = true
        
        clubImageView.leadingAnchor.constraint(equalTo: imageWrapper.leadingAnchor, constant: 10).isActive = true
        clubImageView.trailingAnchor.constraint(equalTo: imageWrapper.trailingAnchor, constant: -10).isActive = true
        clubImageView.centerYAnchor.constraint(equalTo: imageWrapper.centerYAnchor).isActive = true
        
        clubImageView.layoutIfNeeded()
    }
    
    func configureDescriptionWrapper() {
        containerView.addSubview(descriptionWrapper)
        descriptionWrapper.translatesAutoresizingMaskIntoConstraints = false
        descriptionWrapper.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        descriptionWrapper.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.10).isActive = true
        descriptionWrapper.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        descriptionWrapper.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        
        clubNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureIconBar() {
        
        iconBar.axis = .horizontal
        iconBar.distribution = .equalSpacing
        iconBar.alignment = .center
        
        let sizeStack = UIStackView()
        sizeStack.axis = .horizontal
        
        let personImageView = UIImageView(image: UIImage(systemName: "person"))
        personImageView.tintColor = .darkGray
        sizeStack.addArrangedSubview(personImageView)
        sizeStack.addArrangedSubview(sizeLabel)
        
        let applicationStack = UIStackView()
        applicationStack.axis = .horizontal
        
        let applicationImageView = UIImageView(image: UIImage(systemName: "square.and.pencil"))
        applicationImageView.tintColor = .darkGray
        applicationStack.addArrangedSubview(applicationImageView)
        applicationStack.addArrangedSubview(applicationRequiredLabel)
        
        
        let acceptingMemberStack = UIStackView()
        acceptingMemberStack.axis = .horizontal
        
        acceptingMemberStack.addArrangedSubview(acceptingMembersIcon)
        acceptingMemberStack.addArrangedSubview(acceptingMembersLabel)
        
        iconBar.addArrangedSubview(sizeStack)
        iconBar.addArrangedSubview(applicationStack)
        iconBar.addArrangedSubview(acceptingMemberStack)
        descriptionWrapper.addSubview(iconBar)

        applicationRequiredLabel.translatesAutoresizingMaskIntoConstraints = false
        applicationRequiredLabel.widthAnchor.constraint(equalTo: descriptionWrapper.widthAnchor, multiplier: 27/100).isActive = true
        
        acceptingMembersLabel.translatesAutoresizingMaskIntoConstraints = false
        acceptingMembersLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 27/100).isActive = true
        
        iconBar.translatesAutoresizingMaskIntoConstraints = false
        
        iconBar.centerXAnchor.constraint(equalTo: descriptionWrapper.centerXAnchor).isActive = true
        iconBar.widthAnchor.constraint(equalTo: descriptionWrapper.widthAnchor, multiplier: 0.9).isActive = true
        iconBar.bottomAnchor.constraint(equalTo: descriptionWrapper.bottomAnchor).isActive = true
        
        let lineBar = UIView()
        containerView.addSubview(lineBar)
        lineBar.translatesAutoresizingMaskIntoConstraints = false
        lineBar.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.90).isActive = true
        lineBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineBar.bottomAnchor.constraint(equalTo: descriptionWrapper.topAnchor, constant: -10).isActive = true
        lineBar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        lineBar.backgroundColor = .lightGray
    }
    
    func configureClubNameLabel () {
        clubNameLabel.font = UIFont(name: "Avenir-Book", size: 18)
        clubNameLabel.textColor = .black
        containerView.addSubview(clubNameLabel)
        clubNameLabel.adjustsFontSizeToFitWidth = true
        
        self.layoutIfNeeded()
        clubNameLabel.translatesAutoresizingMaskIntoConstraints = false
        clubNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
        clubNameLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2).isActive = true
        clubNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: containerView.bounds.width * 0.05).isActive = true
        clubNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: containerView.bounds.height * 0.05).isActive = true
        clubNameLabel.numberOfLines = 2
    }
    
    
    let tagsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
        
    lazy var inset = containerView.bounds.width * 0.05
    
    func configureTagCellCollection () {
        
        containerView.addSubview(tagsCollection)
        
        tagsCollection.translatesAutoresizingMaskIntoConstraints = false
        tagsCollection.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.15).isActive = true
        tagsCollection.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.60).isActive = true
        tagsCollection.topAnchor.constraint(equalTo: clubNameLabel.bottomAnchor).isActive = true
        tagsCollection.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true

        tagsCollection.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset);
        
        tagsCollection.dataSource = self
        tagsCollection.delegate = self
    }
    
    func configureFadeMask () {
        let fadeMask = CAGradientLayer()
        containerView.layer.addSublayer(fadeMask)
        fadeMask.frame = CGRect(x: tagsCollection.frame.origin.x, y: tagsCollection.frame.origin.y, width: tagsCollection.frame.width, height: tagsCollection.frame.height)
        fadeMask.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        
        fadeMask.locations = [0.03, 0.08, 0.9, 1]
        
        fadeMask.startPoint = CGPoint(x: 0.0, y: 0.5)
        fadeMask.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(tagArray.count)
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath) as! tagCell
        cell.set(tags: tagArray[indexPath.item])
//        DispatchQueue.main.async {
//            self.tagsCollection.reloadData()
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: 90, height: tagsCollection.frame.height * 0.90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

class tagCell: UICollectionViewCell {
    
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    let tagLabel = UILabel()
    let cell = UIView()
    
    func set(tags: Tag) {
        tagLabel.text = tags.name
        tagLabel.textColor = .white
        addSubview(tagLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
