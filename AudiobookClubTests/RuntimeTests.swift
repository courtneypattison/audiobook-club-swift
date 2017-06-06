//
//  RuntimeTests.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-06-06.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import XCTest
@testable import AudiobookClub


class RuntimeTests: XCTestCase {
    
    func test_init_givenRuntimeString_setsRuntime() {
        let runtime = Runtime(string: "10:26:30")
        
        XCTAssertEqual(runtime?.hours, 10)
        XCTAssertEqual(runtime?.minutes, 26)
        XCTAssertEqual(runtime?.seconds, 30)
    }
    
    func test_init_givenInvalidString_returnsNil() {
        let runtime = Runtime(string: "10:26:")
        
        XCTAssertNil(runtime)
    }
    
    func test_description_givenRuntime_setsDescription() {
        let runtime = Runtime(string: "10:26:30")
        
        XCTAssertEqual(runtime?.description(), "10h 26m")
    }
    
    func test_description_givenZeroHours_setsDescriptionWithoutHours() {
        let runtime = Runtime(string: "00:26:30")
        
        XCTAssertEqual(runtime?.description(), "26m")
    }
}
