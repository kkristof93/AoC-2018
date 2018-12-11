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
const sums = [];

for (let y = 0; y < mapSize; y++) {
	map[y] = [];
	sums[y] = [];
	for (let x = 0; x < mapSize; x++) {
		const power = countCell(x + 1, y + 1);
		map[y][x] = power;
		sums[y][x] = power;
	}
}

function countPower(x, y, size) {
	if (size == 1) {
		return map[y][x];
	}

	let sum = sums[y][x];

	for (let i = 0; i < size; i++) {
		sum += map[y + size - 1][x + i];
	}
	for (let i = 0; i < size; i++) {
		sum += map[y + i][x + size - 1];
	}
	sum -= map[y + size - 1][x + size - 1];

	return sum;
}

let max = 0;
let maxSize = 1;
let position = {x: 0, y: 0};

for (let size = 1; size <= mapSize; size++) {
	for (let y = 0; y + size < mapSize; y++) {
		for (let x = 0; x + size < mapSize; x++) {
			const power = countPower(x, y, size);
			if (power > max) {
				max = power;
				maxSize = size;
				position = {x: x + 1, y: y + 1}
			}
			sums[y][x] = power;
		}
	}
}

console.log(`${position.x},${position.y},${maxSize}`)
