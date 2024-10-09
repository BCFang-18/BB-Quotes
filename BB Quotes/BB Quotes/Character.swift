//
//  Character.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/1/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
