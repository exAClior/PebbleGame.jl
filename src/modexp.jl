function plain_adder(A::NTuple{N_A,Bool},B::NTuple{N_B,Bool}) where {N_A,N_B}
    @assert N_A == N_B "A and B must be of the same bits"
    return A .+ B
end

function mod_adder(A::NTuple{N_A,Bool},B::NTuple{N_B,Bool},M::NTuple{N_M,Bool}) where {N_A,N_B,N_M}
    @assert (N_A <= N_M) && (N_B <= N_M) "A and B must be smaller than M"
    return (A .+ B) % M
end


plain_adder((true, true, true),(false,false))
plain_adder((true, true, true),(false,false,false))

mod_adder((true, true, true),(false,false,false), (true,true))
mod_adder((true, true, true),(false,false,false), (true,true, false, false))
