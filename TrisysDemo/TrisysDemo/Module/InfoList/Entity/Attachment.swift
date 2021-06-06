//
//  Attachment.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation

struct Attachment : Codable {
    
    let fileURL: String

    enum CodingKeys: String, CodingKey {
        case fileURL = "fileUrl"
    }
}
