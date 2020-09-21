def bubble_sort(array)
    for i in 1...array.size-1 do
        for j in 0...array.size-i do
            if array[j] > array[j+1]
                array[j], array[j+1] = array[j+1], array[j]
            end
        end
    end
    return print array
end

bubble_sort([4,3,78,2,0,2])