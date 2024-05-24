import XCTest

@testable import JSONService
final class FileDataManagerTests: XCTestCase {
    
    private var fileDataManager: FileDataManager!
    
    override func setUp() {
        super.setUp()
        fileDataManager = FileDataManager()
    }
    
    override func tearDown() {
        fileDataManager = nil
        super.tearDown()
    }
    
    func testGivenDirectoryWithFile_WhenCallRead_ThenResultIsSuccessWithData() {
        let tempDir = FileManager.default.temporaryDirectory
        let tempFileURL = tempDir.appendingPathComponent(UUID().uuidString)
        let testJSON = "{\"id\": 1, \"name\": \"Test\"}"
        let testData = Data(testJSON.utf8)
        
        do {
            try testData.write(to: tempFileURL)
            let readData = try fileDataManager.read(from: tempFileURL)
            XCTAssertEqual(readData, testData)
        } catch {
            return XCTFail("Result should be success")
        }
        
        try? FileManager.default.removeItem(at: tempFileURL)
    }
    
    func testGivenDirectoryWithoutFile_WhenCallRead_ThenResultIsFailureWithFileNotFoundError() {
        let tempDir = FileManager.default.temporaryDirectory
        let nonExistentFileURL = tempDir.appendingPathComponent(UUID().uuidString)
        
        do {
            _ = try fileDataManager.read(from: nonExistentFileURL)
            XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? CocoaError else {
                return XCTFail("Error should be CocoaError")
            }
            
            guard case CocoaError.fileReadNoSuchFile = capturedError else {
                return XCTFail("Error should be fileReadNoSuchFile")
            }
        }
    }
}
