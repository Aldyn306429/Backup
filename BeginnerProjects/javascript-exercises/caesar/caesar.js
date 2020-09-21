const caesar = function(string, value) {
    const arr = [];
    const regEx = /[a-zA-Z]/;
    for(const element of string) {
        if(regEx.test(element)) {
            const start = element === element.toLowerCase() ? 'a'.charCodeAt(0) : 'A'.charCodeAt(0); 
            const dif = element.charCodeAt(0) - start; 
            let finalVal = 0;
            if(value >= 0) {
                finalVal = value + dif; 
            } else {
                if(Math.abs(value) <= 26) {
                    finalVal = dif + Math.abs(26 - Math.abs(value)); 
                } else {
                    finalVal = dif - Math.abs(26 - Math.abs(value)); 
                }; 
            }; 
            const change = (finalVal % 26) + start; 
            arr.push(String.fromCharCode(change)); 
        } else {
            arr.push(element); 
        }
    }

    return arr.join(''); 
}

module.exports = caesar
