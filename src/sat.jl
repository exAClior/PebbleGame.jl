abstract type AbstractProblem end

abstract type SATProblem <: AbstractProblem end

struct SAT{K,T<:Integer} <: SATProblem
    n_vars::Int64
    clauses::Vector{NTuple{K,T}}
end

function SAT{K,T}(clauses::Vector{NTuple{K,T}}) where {K,T}
    n_vars = maximum([maximum(abs.(clause)) for clause in clauses])
    return SAT{K,T}(n_vars, clauses)
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
    n = p.n_vars

    node_group_len = [
        2 * n + 1,
        2 * n - K,
        K,
        3 * K,
        3, # init, d, final
        sum([(2 * n - 2 * k +2) for k in 1:n]),
        sum([(2 * n - 2 * k + 1) for k in 1:n]),
        sum([(2 * n - 2 * k + 1) for k in 1:n]),
        2 * n,
        n,
        2 * n,
        n,
    ]
    node_group_name = ["A", "B", "C", "F", "M", "R", "S", "T", "U", "W", "X", "Z"]

    n_nodes = sum(node_group_len)

    T2 = typemax(Int32) < n_nodes ? Int64 : Int32
    dag = DiGraph{T2}(n_nodes)

    status = zeros(T2, n_nodes)
    pebbles = Dict{String,Vector{T2}}()

    cur_vtx = 1
    for (len, name) in zip(node_group_len, node_group_name)
        pebbles[name] = T2.(cur_vtx:(cur_vtx + len - 1))
        cur_vtx += len
    end

    for name in ["A", "B", "F", "U"]
        for vtx in pebbles[name]
            add_edge!(dag, pebbles["M"][1], vtx)
        end
    end

    for name in ["C", "R", "S", "T", "W"]
        for vtx in pebbles[name]
            add_edge!(dag, pebbles["M"][1], vtx)
        end
    end

    for name in ["W", "X", "Z"]
        for vtx in pebbles[name]
            add_edge!(dag, pebbles["M"][3], vtx)
        end
    end

    add_edge!(dag, pebbles["M"][3], pebbles["M"][1])
    add_edge!(dag, pebbles["M"][3], pebbles["M"][2])

    for (x, z) in zip(pebbles["X"], repeat(pebbles["Z"], 2))
        add_edge!(dag, x, z)
    end

    for (x, u) in zip(pebbles["X"], pebbles["U"])
        add_edge!(dag, x, u)
    end

    for (w, u) in zip(repeat(pebbles["W"], 2), pebbles["U"])
        add_edge!(dag, w, u)
    end

    xs = pebbles["X"] # no copy , later
    for (x, s) in
        zip(vcat([repeat([xs[kk]], 2 * n - 2 * kk + 1) for kk in 1:n]), pebbles["S"])
        add_edge!(dag, x, s)
    end

    for (xbar, t) in
        zip(vcat([repeat([xs[n + kk]], 2 * n - 2 * kk + 1) for kk in 1:n]), pebbles["T"])
        add_edge!(dag, xbar, t)
    end

    zs = pebbles["Z"] # no copy, later
    for (z, r) in
        zip(vcat([repeat([zs[kk]], 2 * n - 2 * kk + 2) for kk in 1:n]), pebbles["R"])
        add_edge!(dag, z, r)
    end

    for kk in 2:n
        add_edge!(dag, pebbles["Z"][kk], pebbles["W"][kk - 1])
        add_edge!(dag, pebbles["Z"][kk], pebbles["Z"][kk - 1])
    end

    for ii in 1:m
        add_edge!(dag, pebbles["C"][ii], pebbles["W"][n])
        add_edge!(dag, pebbles["C"][ii], pebbles["Z"][n])
    end

    for (c, f) in zip(repeat(pebbles["C"], 3), pebbles["F"])
        add_edge!(dag, c, f)
    end

    for name in ["B", "C"]
        for vtx in pebbles[name]
            add!(dag, pebbles["M"][2], vtx)
        end
    end

    return OneShotPebble{T2}(dag, status, pebbles)
end
