//
//  Quote.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/1/24.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
}
