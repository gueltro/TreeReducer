module TreeReducer
    export tmapreduce

    function tmapreduce(f::Function, op::Function, workers::Array{Int}=procs())
        futures = [@spawnat w f() for w in workers]

        return mapreduce(fetch, op, futures)
    end
end # module
