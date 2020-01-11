//
//  ClubDetails.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 11/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

import Foundation

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
    var image_url : String?
    var favorite_count: Int
    var active : Bool
    var target_schools: [Schools]
    var target_majors: [Majors]
    var facebook: String?
    var twitter : String?
    var instagram : String?
    var linkedin : String?
    var github : String?
    var website : String?
    var how_to_get_involved: String
    var listserv: String
    var members : [MemberData]
    var parent_orgs : [String]
    var badges : [Badges]
}
