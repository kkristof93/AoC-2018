import Foundation

let playerCount = 452
let lastMarble = 71250

var last = 0
var marbles = [0]
var points = Array(repeating: 0, count: playerCount)

for i in 1...lastMarble {
	if i % 23 == 0 {
		let removed = marbles.remove(at: (last - 7) >= 0 ? last - 7 : last + marbles.count - 6) 
		last = (last - 7) >= 0 ? last - 7 : last + marbles.count - 6

		points[(i - 1) % playerCount] += i + removed
	} else {
		last = (last + 1) % marbles.count + 1
		marbles.insert(i, at: last)
	}
}

let winScore = points.max()!
print(winScore)
