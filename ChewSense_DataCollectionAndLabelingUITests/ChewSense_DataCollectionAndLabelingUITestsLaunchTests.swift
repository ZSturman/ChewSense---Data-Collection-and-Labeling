//
//  ChewSense_DataCollectionAndLabelingUITestsLaunchTests.swift
//  ChewSense_DataCollectionAndLabelingUITests
//
//  Created by Zachary Sturman on 11/13/25.
//

import XCTest

final class ChewSense_DataCollectionAndLabelingUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the main UI to be visible.
        let navBar = app.navigationBars["Recordings"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5.0), "Recordings screen should be visible on launch.")

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
