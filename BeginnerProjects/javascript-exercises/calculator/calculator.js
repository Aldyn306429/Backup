function add(a, b) {
	return a + b;
}

function subtract(a, b) {
	return a - b;
}

function sum(a) {
	return a.reduce((ans, num) => ans + num, 0); 
}

function multiply(a) {
	return a.reduce((ans, num) => ans * num, 1);
}

function power(a, b) {
	let ans = 1;
	for(let i = 0; i < b; i++) {
		ans *= a; 
	}
	return ans; 
}

function factorial(a) {
	if(a==1) {
		return 1;
	} else if(a == 0) {
		return 1; 
	} else return a * factorial(a-1);
}

module.exports = {
	add,
	subtract,
	sum,
	multiply,
    power,
	factorial
}