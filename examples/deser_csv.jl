# deser_csv

using Serde

struct GradesRecord
    last_name::String
    first_name::String
    ssn::String
    test1::Float64
    test2::Float64
    test3::Float64
    test4::Float64
    final::Float64
    grade::String
end

source = read(joinpath(@__DIR__, "example.csv"), String)

Serde.deser_csv(GradesRecord, source; delimiter = ",")