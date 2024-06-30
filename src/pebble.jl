abstract type AbstractPebbleGame end

# direction will be following the paper
# i -> j means j is the descendant of i
struct OneShotPebble{T<:Integer} <: AbstractPebbleGame
    dag::DiGraph{T}
    status::Vector{T}
    pebbles::Dict{String,Vector{T}}
end
