import Foundation

infix operator +*

extension Array where Element == Int {
	static func +*(lhs: Self, rhs: Self) -> Self {
		guard lhs.count == rhs.count else {
			assertionFailure("Input lenght should be equal values lenght")
			return lhs
		}

		var result = [Int]()

		for (lbit, rbit) in zip(lhs, rhs) {
			result.append((lbit + rbit) % 2)
		}

		return result
	}
}
