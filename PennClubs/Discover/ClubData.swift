//
//  ClubData.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 17/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import UIKit

struct Classification {
    var id : IntegerLiteralType
    var name: String
}

enum tags {
    case A_cappella
    case Academic
    case Advising
    case Arts
    case Athletics
    case Business
    case Civic_engagement
    case Comedy
    case Community_service
    case Competitive
    case Consulting
    case Cultural
    case Dance
    case Engineering
    case Environmental
    case Food
    case Global_affairs
    case Greek_Life
    case Health
    case Journalism
    case Law
    case Medicine
    case Mentorship
    case Music
    case Outdoors
    case Peers_Education
    case Performing_arts
    case Politics
    case Pre_professional
    case Programming
    case Public_speaking
    case Publication
    case Religious
    case Science
    case Social
    case Social_science
    case Special_Interest
    case Sports
    case Student_Government
    case Technology
    case Theatre
    case Travel
    case Umbrella_Organization
    case Writing
    case Youth
}

struct ClubData: Decodable {
    var name : String
    var code : String
    var description : String?
    var founded : String?
    var size : Int?
    var email : String?
    var tags : [Tag]
    var subtitle : String?
    var application_required : Int?
    var accepting_members : Bool
    var image_url : String?
    var favorite_count : Int?
    var active : Bool?
}

struct Tag: Decodable {
    var id: Int
    var name: String
}

