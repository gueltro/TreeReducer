using TreeReducer
using Base.Test

using DistributedArrays

# TreeMapReduce
f = (x -> 2 * x)
op = +
array = [i for i=1:10^3]
darray = distribute(array)

@test reduce(op, array) == tree_reduce(op, darray)
@test mapreduce(f, op, array) == tree_map_reduce(f, op, darray)
