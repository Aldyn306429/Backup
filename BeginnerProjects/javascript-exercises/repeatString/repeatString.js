const repeatString = function(word, iterationCount) {
    let ans = ''; 
    for(let i = 0; i < iterationCount; i++) {
        ans += word; 
    }
    return ans; 
} 

module.exports = repeatString
