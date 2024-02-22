# parse_csv

using Serde

grades = read(joinpath(@__DIR__, "example.csv"), String)

Serde.parse_csv(grades)
