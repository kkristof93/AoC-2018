import Foundation

class Node {
	var value: Int
	var next: Node?
	weak var previous: Node?
	
	public init(value: Int) {
		self.value = value
	}
}

func removeBefore(start: Node, count: Int) -> Node {
	var node = start
	for _ in 0..<count {
		node = node.previous!
	}
	let before = node.previous!
	let after = node.next!

	before.next = after
	after.previous = before

	return node
}

func insertAfter(value: Int, start: Node, count: Int) -> Node {
	var before = start
	for _ in 0..<count {
		before = start.next!
	}
	let after = before.next!

	let newNode = Node(value: value)

	before.next = newNode
	newNode.previous = before

	after.previous = newNode
	newNode.next = after

	return newNode
} 


let playerCount = 452
let lastMarble = 7125000

var last = Node(value: 0)
last.next = last
last.previous = last

var points = Array(repeating: 0, count: playerCount)

for i in 1...lastMarble {
	if i % 23 == 0 {
		let removed = removeBefore(start: last, count: 7)
		last = removed.next!

		points[(i - 1) % playerCount] += i + removed.value
	} else {
		last = insertAfter(value: i, start: last, count: 1)
	}
}

let winScore = points.max()!
print(winScore)
