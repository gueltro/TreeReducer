module TreeReducer
    export tree_map_reduce

    function tree_map_reduce(f::Function, op::Function, workers::Array{Int}=procs())
        futures = [@spawnat w f() for w in workers]

        return mapreduce(fetch, op, futures)
    end
end # module
