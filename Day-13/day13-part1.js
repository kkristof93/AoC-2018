const fs = require('fs');

const file = fs.readFileSync('input.txt', 'utf8');
const lines = file.split('\n');

const directions = ['^', '>', 'v', '<'];

const map = [];
const carts = [];

let i = 0;
for (line of lines) {
	const row = line.split('');

	for (j = 0; j < row.length; j++) {
		if (directions.includes(row[j])) {
			carts.push({
				x: j,
				y: i,
				direction: row[j],
				turn: 0
			});

			row[j] = ['^', 'v'].includes(row[j]) ? '|' : '-';
		}
	}

	map.push(row);
	i++;
}

let crash = null;

while (!crash) {
	carts.sort((a, b) => (a.y - b.y) === 0 ? (a.x - b.x) : a.y - b.y);

	for (cart of carts) {
		switch (cart.direction) {
			case '^': cart.y -= 1; break;
			case 'v': cart.y += 1; break;
			case '<': cart.x -= 1; break;
			case '>': cart.x += 1; break;
		}

		switch (map[cart.y][cart.x]) {
			case '/':
				switch (cart.direction) {
					case '^': cart.direction = '>'; break;
					case 'v': cart.direction = '<'; break;
					case '<': cart.direction = 'v'; break;
					case '>': cart.direction = '^'; break;
				}
				break;

			case '\\':
				switch (cart.direction) {
					case '^': cart.direction = '<'; break;
					case 'v': cart.direction = '>'; break;
					case '<': cart.direction = '^'; break;
					case '>': cart.direction = 'v'; break;
				}
				break;

			case '+':
				const directionIndex = directions.indexOf(cart.direction);
				switch (cart.turn) {
					case 0:
						cart.direction = directions[directionIndex === 0 ? 3 : directionIndex - 1];
						break;
					case 2:
						cart.direction = directions[(directionIndex + 1) % 4];
						break;
				}
				cart.turn = (cart.turn + 1) % 3;
				break;
		}

		if (carts.filter(c => c.x === cart.x && c.y === cart.y).length !== 1) {
			crash = {x: cart.x, y: cart.y};
			break;
		}
	}
}

console.log(`${crash.x},${crash.y}`);
