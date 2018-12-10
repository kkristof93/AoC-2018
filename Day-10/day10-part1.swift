import Foundation

struct Vector {
	let x: Int
	let y: Int

	static func +(lhs: Vector, rhs: Vector) -> Vector {
		return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

	static func *(lhs: Vector, rhs: Int) -> Vector {
		return Vector(x: lhs.x * rhs, y: lhs.y * rhs)
	}
}

class Point {
	var position: Vector
	let velocity: Vector

	init(position: Vector, velocity: Vector) {
		self.position = position
		self.velocity = velocity
	}

	func move() {
		position = position + velocity
	}
}

func parseNumber(_ line: String, _ from: Int, _ to: Int) -> Int {
	let start = line.index(line.startIndex, offsetBy: from)
	let end = line.index(line.startIndex, offsetBy: to)
	let cleared = line[start...end].replacingOccurrences(of: " ", with: "")
	
	return Int(cleared)!
}

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = file.components(separatedBy: "\n")

var points = [Point]()

for line in lines {
	let position = Vector(x: parseNumber(line, 10, 15), y: parseNumber(line, 18, 23))
	let velocity = Vector(x: parseNumber(line, 36, 37), y: parseNumber(line, 40, 41))
	let point = Point(position: position, velocity: velocity)

	points.append(point)
}

var prevArea = Int.max
var area = Int.max

while area <= prevArea {
	points.forEach { $0.move() }

	let xValues = points.map { $0.position.x }
	let yValues = points.map { $0.position.y }
	
	prevArea = area
	area = (xValues.max()! - xValues.min()!) * (yValues.max()! - yValues.min()!)
}

points.forEach { $0.position = $0.position + ($0.velocity * -1) }

let xValues = points.map { $0.position.x }
let yValues = points.map { $0.position.y }

let minX = xValues.min()!
let minY = yValues.min()!
let maxX = xValues.max()!
let maxY = yValues.max()!

var map = Array(repeating: Array(repeating: ".", count: maxX - minX + 1), count: maxY - minY + 1)

points.forEach { 
	map[$0.position.y - minY][$0.position.x - minX] = "#"
}

for line in map {
	print(line.joined(separator: ""))
}
