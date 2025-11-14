//
//  ChewSense_DataCollectionAndLabelingTests.swift
//  ChewSense_DataCollectionAndLabelingTests
//
//  Created by Zachary Sturman on 11/13/25.
//

import Foundation
import Testing
@testable import ChewSense_DataCollectionAndLabeling

struct ChewSense_DataCollectionAndLabelingTests {

    // MARK: - Helpers

    /// Creates a unique temporary session folder inside the app's documents directory
    /// that mimics the structure used by `RecorderController`.
    private func makeTemporarySessionFolder(nameSuffix: String = UUID().uuidString) throws -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folder = docs.appendingPathComponent("TestSession-\(nameSuffix)", isDirectory: true)
        // Ensure a clean state for this folder
        try? FileManager.default.removeItem(at: folder)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        return folder
    }

    // MARK: - RecordingMetadata

    @Test
    func recordingMetadata_isCodableRoundTrip() throws {
        let original = RecordingMetadata(labelled: true, shared: false)

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(RecordingMetadata.self, from: data)

        #expect(decoded.labelled == original.labelled)
        #expect(decoded.shared == original.shared)
    }

    // MARK: - RecorderController metadata lifecycle

    @Test
    func recorderController_metadataLifecycle_singleFolder() throws {
        let controller = RecorderController()
        let folder = try makeTemporarySessionFolder()

        // Starts with no metadata for a brand-new folder.
        #expect(controller.metadata(for: folder) == nil)

        // Mark as labelled.
        controller.setLabelled(true, for: folder)
        let afterLabel = controller.metadata(for: folder)

        #expect(afterLabel != nil)
        #expect(afterLabel?.labelled == true)
        #expect(afterLabel?.shared == false)

        // Mark as shared.
        controller.markShared(for: folder)
        let afterShare = controller.metadata(for: folder)

        #expect(afterShare != nil)
        #expect(afterShare?.labelled == true)
        #expect(afterShare?.shared == true)

        // Deleting the folder should also clear metadata.
        controller.deleteSessionFolder(folder)
        #expect(controller.metadata(for: folder) == nil)
    }

    @Test
    func recorderController_markSharedForMultipleFolders() throws {
        let controller = RecorderController()
        let folder1 = try makeTemporarySessionFolder(nameSuffix: "1")
        let folder2 = try makeTemporarySessionFolder(nameSuffix: "2")

        // Start with per-folder metadata marked as labelled but not shared.
        controller.setLabelled(true, for: folder1)
        controller.setLabelled(true, for: folder2)

        // Mark both as shared in one call.
        controller.markShared(for: [folder1, folder2])

        let meta1 = controller.metadata(for: folder1)
        let meta2 = controller.metadata(for: folder2)

        #expect(meta1?.labelled == true)
        #expect(meta1?.shared == true)

        #expect(meta2?.labelled == true)
        #expect(meta2?.shared == true)

        // Cleanup
        controller.deleteSessionFolder(folder1)
        controller.deleteSessionFolder(folder2)
    }

    // MARK: - RecorderController session folder discovery

    @Test
    func recorderController_allSessionFolders_ignoresHiddenDirectories() throws {
        let controller = RecorderController()
        let visibleFolder = try makeTemporarySessionFolder(nameSuffix: "Visible")

        // Create a hidden directory (name starts with ".") that should be ignored.
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let hiddenName = ".Hidden-\(UUID().uuidString)"
        let hiddenFolder = docs.appendingPathComponent(hiddenName, isDirectory: true)
        try? FileManager.default.removeItem(at: hiddenFolder)
        try FileManager.default.createDirectory(at: hiddenFolder, withIntermediateDirectories: true)

        let all = controller.allSessionFolders()

        // Non-hidden test folder should be present.
        #expect(all.contains(visibleFolder))
        // Hidden folder should not be reported as a session folder.
        #expect(all.contains(hiddenFolder) == false)

        // Cleanup
        controller.deleteSessionFolder(visibleFolder)
        try? FileManager.default.removeItem(at: hiddenFolder)
    }
}
