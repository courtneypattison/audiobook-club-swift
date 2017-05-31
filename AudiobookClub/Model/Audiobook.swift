//
//  Audiobook.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-08.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import UIKit

struct Audiobook {
    
    // MARK: Properties
    
    let identifier: String
    let title: String?
    let authors: [String]?
    let description: String?
    let genres: String?
    let runtime: String?
    let rating: Double?
    let image: URL?
    let chapters: [URL?]?
    
    // MARK: Initialization
    
    init?(identifier: String,
         title: String? = nil,
         authors: [String]? = nil,
         description: String? = nil,
         genres: String? = nil,
         runtime: String? = nil,
         rating: Double? = nil,
         image: URL? = nil,
         chapters: [URL?]? = nil) {
        
        // Initialization should fail if there's no identifier
        guard !identifier.isEmpty else {
            return nil
        }
        
        // Initialization should fail if rating isn't between 0 and 5
        if let rating = rating {
            guard rating >= 0.0 && rating <= 5.0 else {
                return nil
            }
        }
        
        // Initialize stored properties
        self.identifier = identifier
        self.title = title
        self.authors = authors
        self.description = description
        self.genres = genres
        self.runtime = runtime
        self.rating = rating
        self.image = image
        self.chapters = chapters
    }
    
}
