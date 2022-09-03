import Foundation

let sbox = SBox(7,6,5,4,3,2,1,0)

if let result = sbox(1,1,1,1,0,0,0,0) {
	print(result)
}


let elements = [0, 1]  // [0, 1]
let alpha = elements.generate(8)
let betta = elements.generate(8)

print((alpha + betta).generate(2).count)

var cringe = 0
for _ in 0...262144*256 {
	cringe += 1
}

print("cringe")
