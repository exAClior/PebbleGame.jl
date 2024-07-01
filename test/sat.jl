using Test, PebbleGame

@testset "KSAT" begin
    num_variables = 10
    num_clauses = 20

    assignment = rand(Bool, num_variables)
    true_literals = rand(1:num_variables, num_clauses)

    true_literals =
        [assignment[true_literals[i]] ? 1 : -1 for i in 1:num_clauses] .* true_literals

    clauses = [
        (rand([1, -1], 2) .* rand(1:num_variables, 2)..., true_literals[i]) for
        i in 1:num_clauses
    ]
    p = SAT{3,Int}(clauses)

    @test evaluate(p, assignment)

    # reduce(p, :ONESHOT)
end
