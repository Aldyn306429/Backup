const palindromes = function(a) {
    a = a.toLowerCase().replace(/[^A-Za-z]/g, '');
    if(a === a.split('').reverse().join('')) {
        return true;
    } else return false; 
}

module.exports = palindromes
