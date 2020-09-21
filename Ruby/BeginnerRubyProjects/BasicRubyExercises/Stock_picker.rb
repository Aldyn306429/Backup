def stock_picker(array)
    ans = []
    value = 0
    for i in 1..array.size do
        if array[i].to_i > value
            value = array[i].to_i
            firstAns = i
        end
    end
    value = array[0]
    for i in 1..firstAns do
        if array[i].to_i < value
            value = array[i].to_i
            secondAns = i
        end
    end
    ans.push(secondAns)
    ans.push(firstAns)

    return print ans
end

stock_picker([17,3,6,9,15,8,6,1,10])