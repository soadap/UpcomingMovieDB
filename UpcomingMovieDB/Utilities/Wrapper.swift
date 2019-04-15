//
//  Wrapper.swift
//  Stack Overflow
//
//  Created by Peter Gustafson on 4/9/19.
//  Copyright © 2019 Peter Gustafson. All rights reserved.
//

import Foundation

struct Wrapper: Codable {
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
