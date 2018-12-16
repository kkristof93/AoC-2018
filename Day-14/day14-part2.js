const input = '047801';
const inputArray = input.split('').map(i => parseInt(i, 10));

const scores = [3, 7];

let first = 0;
let second = 1;

function equalsInput(start) {
	for (let i = 0; i < inputArray.length; i++) {
		if (scores[start + i] !== inputArray[i]) {
			return false;
		}
	}
	return true;
}

while (!equalsInput(scores.length - inputArray.length - 1) && !equalsInput(scores.length - inputArray.length)) {
	const score = scores[first] + scores[second];
	if (score < 10) {
		scores.push(score);
	} else {
		scores.push(Math.floor(score / 10));
		scores.push(score % 10);
	}

	first = (first + 1 + scores[first]) % scores.length;
	second = (second + 1 + scores[second]) % scores.length;
}

const index = scores.length - inputArray.length - (equalsInput(scores.length - inputArray.length - 1) ? 1 : 0);
console.log(index);
