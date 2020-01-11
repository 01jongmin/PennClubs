//
//  MemberCell.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 11/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import UIKit
import Kingfisher

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
