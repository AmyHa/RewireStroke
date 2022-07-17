//
//  ActivityViewModelTests.swift
//  RewireStrokeTests
//
//  Created by Amy Ha on 08/08/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import XCTest
@testable import RewireStroke

class ActivityViewModelTests: XCTestCase {

    var activityViewModel: ActivityViewModel!
    var data: WorkoutPlaceholderData!
    
    override func setUp() {
        data = WorkoutPlaceholderData()
        activityViewModel = ActivityViewModel(data: data)
    }
    
    override func tearDown() {
        data = nil
        activityViewModel = nil
    }
    override class func tearDown() {
        print("tear down ran")
    }
    
//    func test_afterInitialisation_ULWorkoutsContainsTwoWorkouts() {
//        let sut = activityViewModel.data.ULworkouts
//
//        XCTAssertEqual(sut?.count, 2)
//    }
//
//    func test_afterInitialisation_BAWorkoutsContainsFourWorkouts() {
//        let sut = activityViewModel.data.BAWorkouts
//
//        XCTAssertEqual(sut?.count, 4)
//    }

    func test_afterIntialisation_ULWorkoutsFirstItemContainsPreassessmentPlaceholderImage() {
        let sut = activityViewModel.data.ULworkouts[0]
        
        XCTAssertEqual(sut.image, "ULAssessmentThumbnail")
    }
    
    func test_afterIntialisation_ULWorkoutsSecondItemContainsPreassessmentUnlockImage() {
        let sut = activityViewModel.data.ULworkouts[1]
        
        XCTAssertEqual(sut.image, "UnlockAssessment")
    }
    
    func test_afterIntialisation_BAWorkoutsFirstItemContainsPreassessmentPlaceholderImage() {
        let sut = activityViewModel.data.BAWorkouts[0]
        
        XCTAssertEqual(sut.image, "BalanceBodyScanThumbnail")
    }
    
    func test_afterIntialisation_BAWorkoutsThirdItemContainsHipBalanceImage() {
        let sut = activityViewModel.data.BAWorkouts[2]
        
        XCTAssertEqual(sut.image, "BAHipBalanceThumbnail")
    }
}
