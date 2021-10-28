//
//  Film.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import Foundation


struct Film: Codable {
    let title: String
    let year: String
    let poster: String
    let plot: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        poster = try container.decode(String.self, forKey: .poster)
        plot = try container.decode(String.self, forKey: .plot)
    }
}
