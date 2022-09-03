import Foundation

struct SBox {
	private let subIndexes: [Int]

	init(_ subIndexes: Int...) {
		self.subIndexes = subIndexes
	}

	func callAsFunction(_ input: Int...) -> [Int]? {
		guard input.count == subIndexes.count else {
			assertionFailure("Input lenght should be equal values lenght")
			return nil
		}

		var result = Array(repeating: 0, count: input.count)

		for (value, index) in zip(input, subIndexes) {
			result[index] = value
		}

		return result
	}
}
