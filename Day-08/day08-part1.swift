import Foundation

struct Node {
	let number: Int
	var childCount: Int = 0
	var metadataCount: Int = 0
	var parent: Int?
	var children = [Int]()
	var metadata = [Int]()

	init(number: Int, parent: Int?) {
		self.number = number
		self.parent = parent
	}
}

enum State {
	case childCount(Int?)
	case metadataCount
	case metadata(Int, Int)
}

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let numbers = file.components(separatedBy: " ")

var tree = [Node]()

var current = 0
var state: State = .childCount(nil)

for num in numbers {
	let number = Int(num)!

	switch state {
	case .childCount(let parent):
		tree.insert(Node(number: current, parent: parent), at: current)
		tree[current].childCount = number

		if let parent = parent {
			tree[parent].children.append(current)
		}

		state = .metadataCount

	case .metadataCount:
		tree[current].metadataCount = number
		if tree[current].childCount == 0 {
			state = .metadata(current, number)
		} else {
			state = .childCount(current)
			current += 1
		}

	case .metadata(let index, let count):
		tree[index].metadata.append(number)
		if count - 1 > 0 {
			state = .metadata(index, count - 1)
		} else {
			if let parent = tree[index].parent {
				if tree[parent].childCount != tree[parent].children.count {
					current += 1
					state = .childCount(parent)
				} else {
					state = .metadata(parent, tree[parent].metadataCount)
				}
			}
			
		}
	}
}

let metadatas = tree.flatMap { $0.metadata }
let sum = metadatas.reduce(0, +)

print(sum)
