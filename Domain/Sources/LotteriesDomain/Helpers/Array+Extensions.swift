import Foundation

extension Array where Element: Hashable {
    
    func haveCommonElements(numberOfCummonElements: Int, array: [Element]) -> Bool {
        let set1 = Set(self)
        let set2 = Set(array)
        let commonElements = set1.intersection(set2)
        return commonElements.count >= numberOfCummonElements
    }
}
