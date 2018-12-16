const input = '047801';
const number = parseInt(input, 10);

const scores = [3, 7];

let first = 0;
let second = 1;

while (scores.length < number + 10) {
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

const solution = scores.slice(number).join('');
console.log(solution);
