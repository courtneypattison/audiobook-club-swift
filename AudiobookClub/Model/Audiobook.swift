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
    let runtime: Runtime?
    let rating: Double?
    let imageURL: URL?
    var chapters: [URL]?
    
    // MARK: Initialization
    
    init?(identifier: String,
          title: String? = nil,
          authors: [String]? = nil,
          description: String? = nil,
          subjects: String? = nil,
          runtime: Runtime? = nil,
          rating: Double? = nil,
          imageURL: URL? = nil,
          chapters: [URL]? = nil) {
        
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
    
    init?(data json: JSON) {
        let identifiers = json["metadata"]["identifier"].arrayValue
        let titles = json["metadata"]["title"].arrayValue
        let authors = json["metadata"]["creator"].arrayValue
        let descriptions = json["metadata"]["description"].arrayValue
        let subjects = json["metadata"]["subject"].arrayValue
        let runtimes = json["metadata"]["runtime"].arrayValue
        
        if identifiers.count >= 1, let identifier = identifiers[0].string, !identifier.isEmpty {
            self.identifier = identifier
        } else {
            return nil
        }
        
        if titles.count >= 1, let title = titles[0].string, !title.isEmpty {
            self.title = title
        } else {
            self.title = nil
        }
        
        if authors.count >= 1 {
            self.authors = []
            for author in authors {
                if let authorStr = author.string, !authorStr.isEmpty {
                    self.authors?.append(authorStr)
                }
            }
        } else {
            self.authors = nil
        }
        
        if descriptions.count >= 1, let description = descriptions[0].string, !description.isEmpty {
            self.description = cleanDescription(description: description)
        } else {
            self.description = nil
        }
        
        if subjects.count >= 1, let subjectsStr = subjects[0].string, !subjects.isEmpty {
            
            self.subjects = cleanSubjects(subjects: subjectsStr)
        } else {
            self.subjects = nil
        }
        
        if runtimes.count >= 1, let runtime = runtimes[0].string, !runtime.isEmpty {
            self.runtime = Runtime(string: runtime)
        } else {
            self.runtime = nil
        }
        
        if let ratingStr = json["reviews"]["info"]["avg_rating"].string, !ratingStr.isEmpty {
            self.rating = Double(ratingStr)
        } else {
            self.rating = nil
        }

        if let imageURLStr = json["misc"]["image"].string, !imageURLStr.isEmpty {
            self.imageURL = URL(string: imageURLStr)
        } else {
            self.imageURL = nil
        }
        
        self.chapters = []
        for (file,_):(String, JSON) in json["files"] {
            if file.hasSuffix(".mp3") {
                if let url = URL(string: "https://archive.org/download/" + self.identifier + file) {
                    self.chapters?.append(url)
                }
            }
        }
        if chapters?.count == 0 {
            self.chapters = nil
        }
    }
}

// Mark: Helper functions

func cleanDescription(description: String) -> String {
    return description.replacingOccurrences(of: "(<[^>]+>|\n\nFor further information,[^\n]+|\n\nFor more[^\n]+)", with: "", options: .regularExpression)
        .replacingOccurrences(of: "\n(Download )?M4B[^\n]+", with: "", options: .regularExpression)
        .replacingOccurrences(of: "\n\n+", with: "\n\n", options: .regularExpression)
        .trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
}

func cleanSubjects(subjects: String) -> String {
    return subjects.replacingOccurrences(of: "(audio( ?books?)?|librivox);?", with: "", options: [.regularExpression, .caseInsensitive])
        .replacingOccurrences(of: "; *", with: ", ", options: .regularExpression)
        .trimmingCharacters(in: CharacterSet(charactersIn: " ,"))
}
