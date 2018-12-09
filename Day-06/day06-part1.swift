import Foundation

struct Location {
	let number: Int
	let x: Int
	let y: Int
}

enum Field {
	case location(Location)
	case closestTo(Location, Int)
	case equalDistance
	case none
}

enum Size {
	case finite(Int)
	case infinite

	var isFinite: Bool {
		switch self {
		case .finite(_): return true
		default: return false
		}
	}

	var value: Int? {
		switch self {
		case .finite(let val): return val
		default: return nil
		}
	}
    
}

func +(lhs: Size, rhs: Size) -> Size {
	if case let .finite(a) = lhs, case let .finite(b) = rhs {
		return Size.finite(a + b)
	}
	return Size.infinite
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

var grid: [[Field]] = Array(repeating: Array(repeating: .none, count: size.y), count: size.x)
locations.forEach { grid[$0.x][$0.y] = .location($0) }

for i in 0..<grid.count {
	for j in 0..<grid[i].count {
		let field = grid[i][j]

		if case .none = field {
			let locationDistance = locations.map { (location: $0, distance: abs(i - $0.x) + abs(j - $0.y)) }
			let sortedByDistance = locationDistance.sorted { $0.distance < $1.distance }

			if sortedByDistance[0].distance == sortedByDistance[1].distance {
				grid[i][j] = .equalDistance
			} else {
				let closest = sortedByDistance[0]
				grid[i][j] = .closestTo(closest.location, closest.distance)
			}
		}
	}
}

var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: size.y), count: size.x)

func dfs(number: Int, x: Int, y: Int) -> Size {
	if x < 0 || y < 0 || x == size.x || y == size.y {
		return .infinite
	}
	if visited[x][y] {
		return .finite(0)
	}

	switch grid[x][y] {
	case .location(let location), .closestTo(let location, _):
		if location.number == number {
			visited[x][y] = true

			return .finite(1) 
			+ dfs(number: number, x: x + 1, y: y)
			+ dfs(number: number, x: x - 1, y: y)
			+ dfs(number: number, x: x, y: y + 1)
			+ dfs(number: number, x: x, y: y - 1)
		}
		return .finite(0)
	default:
		return .finite(0)
	}
}

let locationSizes = locations.map { (location: $0, size: dfs(number: $0.number, x: $0.x, y: $0.y)) }
let sortedBySize = locationSizes
	.filter { $0.size.isFinite }
	.compactMap { $0.size.value }
	.sorted { $0 > $1 }

print(sortedBySize[0])
