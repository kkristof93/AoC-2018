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

func getTime(_ c: Character) -> Int {
	let a = Character("A")
	return Int(c.unicodeScalars.first!.value) - Int(a.unicodeScalars.first!.value) + 1 + 60
}

let workers = 5
var done = [Character: Bool]()
var queue = [Character]()
var remaining = [Character: Int]()
var activeWorkers = 0

let starts = graph.keys.sorted().filter { routes[$0] == nil }
for start in starts {
	remaining[start] = getTime(start)
	queue.append(start)
	activeWorkers += 1
}

var order = [Character]()

var time = 0
while queue.count > 0 {
	for (c, rem) in remaining {
		if rem - 1 == 0 {
			done[c] = true
			remaining[c] = nil
			activeWorkers -= 1

			queue = queue.filter { $0 != c }
			queue.append(contentsOf: graph[c, default: []])
			queue.sort()

			order.append(c)
		} else {
			remaining[c] = rem - 1
		}
	}

	while activeWorkers < workers, 
		let next = queue.first(where: { routes[$0, default: []].allSatisfy { done[$0, default: false] } && remaining[$0] == nil }) {
		queue.append(contentsOf: graph[next, default: []])
		queue.sort()

		remaining[next] = getTime(next)
		activeWorkers += 1
	}

	time += 1
}

print(time)
