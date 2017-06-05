//
//  Audiobook.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-08.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//
import UIKit

import SwiftyJSON

struct Audiobook {
    
    // MARK: Properties
    
    let identifier: String
    let title: String?
    let authors: [String]?
    let description: String?
    let subjects: String?
    let runtime: String?
    let rating: Double?
    var imageURL: URL?
    let chapters: [URL?]?
    
    // MARK: Initialization
    
    init?(identifier: String,
          title: String? = nil,
          authors: [String]? = nil,
          description: String? = nil,
          subjects: String? = nil,
          runtime: String? = nil,
          rating: Double? = nil,
          imageURL: URL? = nil,
          chapters: [URL?]? = nil) {
        
        // Initialization should fail if there's no identifier
        guard !identifier.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.identifier = identifier
        self.title = title
        self.authors = authors
        self.description = description
        self.subjects = subjects
        self.runtime = runtime
        self.rating = rating
        self.imageURL = imageURL
        self.chapters = chapters
    }
    
    init?(metadata json: JSON, imageURL: URL?) {
        guard let identifier = json["identifier"].string else {
            return nil
        }
        
        var rating: Double? = nil
        if let ratingStr = json["avg_rating"].string {
            rating = Double(ratingStr)
        }
        
        self.identifier = identifier
        self.title = json["title"].string ?? nil
        self.authors = [json["creator"].string ?? ""]
        self.description = nil
        self.subjects = nil
        self.runtime = json["runtime"].string ?? nil
        self.rating = rating
        self.imageURL = imageURL
        self.chapters = nil
    }
}
