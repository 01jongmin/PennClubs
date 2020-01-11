//
//  ClubData.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 17/12/2019.
//  Copyright © 2019 CHOI Jongmin. All rights reserved.
//

import UIKit

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

struct MemberData: Decodable {
    var name : String
    var title : String
    var active : Bool
    var `public` : Bool
    var image : String?
}

struct ClubDetailsData: Decodable {
    var name : String
    var code : String
    var description : String
    var founded : String?
    var size : Int
    var email : String?
    var tags : [Tag]
    var subtitle : String
    var application_required: Int
    var accepting_members: Bool
    var image_url : String
    var favorite_count: Int
    var active : Bool
    var target_schools: [Schools]
    var target_majors: [Majors]
    var facebook: String
    var twitter : String
    var instagram : String
    var linkedin : String
    var github : String
    var website : String
    var how_to_get_involved: String
    var listserv: String
    var members : [MemberData]
    var parent_orgs : [String]
    var badges : [Badges]
}

struct Badges : Decodable {
    var id: Int
    var label: String
    var color : String
    var description: String
}

struct Schools : Decodable {
    var id: Int
    var name: String
}

struct Majors : Decodable {
    var id: Int
    var name: String
}

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

struct Tag: Decodable {
    var id: Int
    var name: String
}

enum discoverMode {
    case Clubs
    case Events
}

