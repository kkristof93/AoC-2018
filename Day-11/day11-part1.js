const serial = 4842;
const mapSize = 300;

function countCell(x, y) {
	const rackId = x  + 10;
	let powerLevel = rackId * y;
	powerLevel += serial;
	powerLevel *= rackId;
	powerLevel = Math.floor(powerLevel / 100) % 10;
	powerLevel -= 5;

	return powerLevel;
}

const map = [];

for (let y = 0; y < mapSize; y++) {
	map[y] = [];
	for (let x = 0; x < mapSize; x++) {
		map[y][x] = countCell(x + 1, y + 1);
	}
}

function countPower(x, y) {
	let sum = 0;
	for (let i = 0; i <= 2; i++) {
		for (let j = 0; j <= 2; j++) {
			sum += map[y + i][x + j];
		}
	}
	return sum;
}

let max = 0;
let position = {x: 0, y: 0};

for (let y = 0; y + 2 < mapSize; y++) {
	for (let x = 0; x + 2 < mapSize; x++) {
		const power = countPower(x, y);
		if (power > max) {
			max = power;
			position = {x: x + 1, y: y + 1}
		}
	}
}

console.log(`${position.x},${position.y}`)
