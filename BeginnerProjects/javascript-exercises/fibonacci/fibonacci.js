const fibonacci = function(value) {
    if(value >= 1) {
        if(value == 1) {
            return 1;
        } else if(value == 2) {
            return 1;
        } else {
            return fibonacci(value - 1) + fibonacci(value - 2); 
        }; 
    } else {
        return 'OOPS'; 
    }
}



module.exports = fibonacci
