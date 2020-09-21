def caesar_cipher(string, key) 
    string = string.split('');
    ans = []
    for i in 0...string.length do
        if string[i].ord >= 65 && string[i].ord < 97
            a = string[i].ord - 65 + key
            total = a % 26
            ans.push((total + 65).chr)
        elsif string[i].ord >= 97 && string[i].ord < 129
            a = string[i].ord - 97 + key
            total = a % 26
            ans.push((total + 97).chr)
        else ans.push(string[i])
        end
    end
    return puts ans.join('')
end

caesar_cipher('What a string!', 5)