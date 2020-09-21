dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, dictionary)
    ans = Hash.new(0)
    for word in dictionary do
        if string.downcase.include? word
            ans[word] += 1
        end
        ans
    end

    return puts ans
end

substrings('below', dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)