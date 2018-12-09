import Foundation

struct Location {
	let number: Int
	let x: Int
	let y: Int
}

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = file.components(separatedBy: "\n")

var num = 0
var size = (x: 0, y: 0)
var locations = [Location]()

for line in lines {
	let coords = line.components(separatedBy: ", ")
	let x = Int(coords[0])!
	let y = Int(coords[1])!

	locations.append(Location(number: num, x: x, y: y))
	size = (x: max(size.x, x + 1), y: max(size.y, y + 1))
	num += 1
}

var safeSize = 0

for i in 0..<size.x {
	for j in 0..<size.y {
		let locationDistance = locations.map { abs(i - $0.x) + abs(j - $0.y) }
		let sum = locationDistance.reduce(0, +)

		if sum < 10000 {
			safeSize += 1
		}
	}
}

print(safeSize)
