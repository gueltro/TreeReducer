module TreeReducer
    using DistributedArrays

    export tree_reduce, tree_map_reduce

    function tree_reduce(op::Function, darray::DArray)
        return tree_map_reduce((x -> x), op, darray)
    end

    function tree_map_reduce(f::Function, op::Function, darray::DArray)
        workers = [p for p in procs(darray)]
        futures = [@spawnat w local_map_reduce(f, op, darray) for w in workers]

        return mapreduce(fetch, op, futures)
    end

    function local_map_reduce(f::Function, op::Function, darray::DArray)
        return mapreduce(f, op, localpart(darray))
    end

end # module
