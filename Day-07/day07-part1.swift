import Foundation

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = file.components(separatedBy: "\n")

var graph = [Character: [Character]]()
var routes = [Character: [Character]]()

for line in lines {
	let before = line[line.index(line.startIndex, offsetBy: 5)]
	let after = line[line.index(line.startIndex, offsetBy: 36)]

	var item = graph[before, default: []]
	item.append(after)
	graph[before] = item

	var route = routes[after, default: []]
	route.append(before)
	routes[after] = route
}

var visited = [Character: Bool]()
var queue = [Character]()
var order = [Character]()

func bfs() {
	let next = queue.first { routes[$0, default: []].allSatisfy { visited[$0, default: false] } }!
	queue = queue.filter { $0 != next }

	guard !visited[next, default: false] else {
		return
	}

	visited[next] = true
	order.append(next)

	queue.append(contentsOf: graph[next, default: []])
	queue.sort()

	while queue.count > 0 {
		bfs()
	}
}

let starts = graph.keys.sorted().filter { routes[$0] == nil }
queue.append(contentsOf: starts)

bfs()

let steps = order.map { String($0) }.joined(separator: "")
print(steps)
