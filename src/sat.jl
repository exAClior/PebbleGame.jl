abstract type AbstractProblem end

abstract type SATProblem <: AbstractProblem end

struct SAT{K,T<:Integer} <: SATProblem
    clauses::Vector{NTuple{K,T}}
end

function evaluate(p::SAT{K,T}, assignment::Vector{Bool}) where {K,T}
    return all(
        clause -> mapfoldr(var -> !xor(var > 0, assignment[abs(var)]), |, clause), p.clauses
    )
end

function reduce(p::SAT{K,T}, type::Symbol) where {K,T}
    if type == :ONESHOT
        reduce2oneshot(p)
    else
        error("Reduction to $type problem is not implemented yet!")
    end
end

function reduce2oneshot(p::SAT{K,T}) where {K,T}
end
