//
//  ContactInfo.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation

struct ContactInfo : Codable {

    let userId : String?
    let userName: String?
    let profileImage: String?
    let title : String?
    let description: String?
    let attachments: [Attachment]?

}
