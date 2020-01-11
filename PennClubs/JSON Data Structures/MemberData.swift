//
//  MemberData.swift
//  PennClubs
//
//  Created by CHOI Jongmin on 11/1/2020.
//  Copyright © 2020 CHOI Jongmin. All rights reserved.
//

struct MemberData: Decodable {
    var name : String
    var title : String
    var active : Bool
    var `public` : Bool
    var image : String?
}
