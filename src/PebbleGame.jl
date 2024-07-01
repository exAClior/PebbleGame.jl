module PebbleGame

using Graphs
# Write your package code here.
include("sat.jl")
export SAT, evaluate, reduce

include("pebble.jl")

include("oneshot.jl")

end
