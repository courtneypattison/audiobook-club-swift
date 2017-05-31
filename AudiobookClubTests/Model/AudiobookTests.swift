//
//  AudiobookTests.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-05-08.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import XCTest
@testable import AudiobookClub

class AudiobookTests: XCTestCase {
    
    var identifier: String!
    
    override func setUp() {
        super.setUp()
        identifier = "jane_eyre_ver03_0809_librivox"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init_givenIdentifier_setsIdentifier() {
        guard let audiobook = Audiobook(identifier: identifier) else {
            fatalError("Invalid identifier");
        }
        
        XCTAssertEqual(audiobook.identifier, identifier)
    }
    
    func test_init_givenEmptyIdentifier_initFails() {
        let emptyIdentifier = ""
        let audiobook = Audiobook(identifier: emptyIdentifier)
        
        XCTAssertNil(audiobook)
    }
    
    func test_init_givenTitle_setsTitle() {
        let title = "Jane Eyre (version 3)"
        guard let audiobook = Audiobook(identifier: identifier,
                                        title: title) else {
            fatalError("Invalid title")
        }
        
        XCTAssertEqual(audiobook.title, title)
    }
    
    func test_init_givenAuthor_setsAuthor() {
        let author = "Charlotte Brontë"
        let authors = [author]
        guard let audiobook = Audiobook(identifier: identifier, authors: authors) else {
            fatalError("Invalid author")
        }
        
        if audiobook.authors?.isEmpty == false {
            XCTAssertEqual(audiobook.authors!, authors)
            XCTAssertEqual(audiobook.authors![0], author)
        }
    }
    
    func test_init_givenDescription_setsDescription() {
        let description = "<a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox</a> recording of Jane Eyre, by Charlotte Brontë. Read by Elizabeth Klett.\n\n" +
        "Charlotte Bronte's classic novel Jane Eyre is narrated by the title character, an orphan who survives neglect and abuse to become a governess at the remote Thornfield Hall. She finds a kindred spirit in her employer, the mysterious and brooding Mr. Rochester, but he hides a terrible secret that threatens their chances of happiness. (Summary by Elizabeth Klett)\n\n" +
        "For further information, including links to online text, reader information, RSS feeds, CD cover or other formats (if available), please go to the LibriVox <a href=\"https://librivox.org/jane-eyre-version-3-by-charlotte-bronte/\" rel=\"nofollow\">catalog page</a> for this recording.\n\n" +
        "For more free audio books or to become a volunteer reader, visit <a href=\"http://librivox.org/\" rel=\"nofollow\">LibriVox.org</a>.\n\n" +
        "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart1_librivox.m4b\" rel=\"nofollow\">Download M4B Part 1 (255MB)</a>\n" +
        "<a href=\"https://archive.org/download/jane_eyre_ver03_0809_librivox/JaneEyrepart2_librivox.m4b\" rel=\"nofollow\">Download M4B Part 2 (273MB)</a>\n"
        
        guard let audiobook = Audiobook(identifier: identifier, description: description) else {
            fatalError("Invalid description")
        }
        
        XCTAssertEqual(audiobook.description, description)
    }
    
    func test_init_givenGenre_setsGenre() {
        let genres = "librivox; audiobook; classic; romance;"
        guard let audiobook = Audiobook(identifier: identifier, genres: genres) else {
            fatalError("Invalid genres")
        }
        
        XCTAssertEqual(audiobook.genres, genres)
    }
    
    func test_init_givenEmptyGenres_setsGenreEmptyString() {
        let genres = ""
        let genresWithoutGeneric = ""
        guard let audiobook = Audiobook(identifier: identifier, genres: genres) else {
            fatalError("Invalid genres")
        }
        
        XCTAssertEqual(audiobook.genres, genresWithoutGeneric)
    }
    
    func test_init_givenRuntime_setsRuntime() {
        let runtime = "18:36:29"
        guard let audiobook = Audiobook(identifier: identifier, runtime: runtime) else {
            fatalError("Invalid runtime")
        }
        
        XCTAssertEqual(audiobook.runtime, runtime)
    }
    
    func test_init_givenRating_setsRating() {
        let rating = 5.00
        guard let audiobook = Audiobook(identifier: identifier, rating: rating) else {
            fatalError("Invalid rating")
        }
        
        XCTAssertEqual(audiobook.rating, rating)
    }
    
    func test_init_givenNegativeRating_initFails() {
        let rating = -1.00
        let audiobook = Audiobook(identifier: identifier,
                                        rating: rating)
        
        XCTAssertNil(audiobook)
    }
    
    func test_init_givenImage_setsImage() {
        let image = URL(string: "https://ia802702.us.archive.org/18/items/jane_eyre_ver03_0809_librivox/Jane_Eyre_1002_thumb.jpg")
        guard let audiobook = Audiobook(identifier: identifier,
                                        image: image) else {
            fatalError("Invalid image")
        }
        
        XCTAssertEqual(audiobook.image, image)
    }
    
    func test_init_givenChapterURLs_setsChapterURLs() {
        let url = URL(string: "https://archive.org/download/jane_eyre_ver03_0809_librivox/janeeyre_01_bronte.mp3")
        let chapters = [url]
        guard let audiobook = Audiobook(identifier: identifier,
                                        chapters: chapters) else {
            fatalError("Invalid chapters")
        }
        
        guard let audiobookChapters = audiobook.chapters else {
            fatalError("Invalid chapters")
        }
        
        XCTAssertEqual(audiobookChapters[0], chapters[0])
    }

    
}
