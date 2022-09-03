import Foundation

extension RangeReplaceableCollection {
	var combinations: [Self] { generate(2) }
	func generate(_ n: Int) -> [Self] {
		repeatElement(self, count: n).reduce([.init()]) { result, element in
			result.flatMap { elements in
				element.map { elements + CollectionOfOne($0) }
			}
		}
	}
}
