import XCTest
@testable import LotteriesDomain

final class LotteriesStoreTests: XCTestCase {
    
    private let storeKey = "lotteries-test-store"
    private let character = Lottery.fixture()
    
    private var store: LotteriesStore!
    private var mockKeyValueStorage: MockKeyValueStorage!
    
    override func setUp() {
        super.setUp()
        mockKeyValueStorage = MockKeyValueStorage()
        store = LotteriesStore(storage: mockKeyValueStorage, storeKey: storeKey)
    }
    
    override func tearDown() {
        mockKeyValueStorage = nil
        store = nil
        super.tearDown()
    }
    
    func testFetchAllEmpty() throws {
        store = LotteriesStore(storage: FakeStore())
        XCTAssertTrue(try store.fetchAll().isEmpty)
    }
    
    func testSaveCharacter() throws {
        store = LotteriesStore(storage: FakeStore())
        XCTAssertFalse(store.contains(character: character))
        try store.save(character: character)
        XCTAssertTrue(store.contains(character: character))
    }
    
    func testContainsCharacter() throws {
        store = LotteriesStore(storage: FakeStore())
        try store.save(character: character)
        XCTAssertTrue(store.contains(character: character))
    }
    
    func testItUsesKeyValueStorageToFetchAllCorrectly() throws {
        var didCallGetValue = false
        mockKeyValueStorage.stubGETValue = { _ in
            didCallGetValue = true
            return [self.character]
        }
        
        let _  = try store.fetchAll()
        XCTAssertTrue(didCallGetValue)
    }
    
    func testItUsesKeyValueStorageToSaveCorrectly() throws {
        var didCallStore = false
        var capturedKey = ""
        mockKeyValueStorage.stubStore = { _, key in
            didCallStore = true
            capturedKey = key
        }
        
        var didCallGetValue = false
        mockKeyValueStorage.stubGETValue = { _ in
            didCallGetValue = true
            return [self.character]
        }
        
        try store.save(character: character)
        XCTAssertTrue(didCallStore)
        XCTAssertTrue(didCallGetValue)
        XCTAssertEqual(capturedKey, storeKey)
    }
    
    func testItUsesKeyValueStorageToGetValueCorrectly() throws {
        var didCallGetValue = false
        mockKeyValueStorage.stubGETValue = { _ in
            didCallGetValue = true
            return [self.character]
        }
        
        let contains = store.contains(character: character)
        
        XCTAssertTrue(didCallGetValue)
        XCTAssertTrue(contains)
    }
}
