# to_csv

using Serde

struct Desc
    author::String
    comment::String
end

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
    desc::Desc
end

function generate_grades_records_array()
    grades_records_array = GradesRecord[]

    for i in 1:1000
        # Sample data for demonstration purposes
        last_name = "LastName_$i"
        first_name = "FirstName_$i"
        ssn = "SSN_$i"
        test1 = rand(50.0:100.0)
        test2 = rand(50.0:100.0)
        test3 = rand(50.0:100.0)
        test4 = rand(50.0:100.0)
        final = rand(50.0:100.0)
        grade = "A"
        desc = Desc("Author_$i", "Comment_$i")

        record = GradesRecord(last_name, first_name, ssn, test1, test2, test3, test4, final, grade, desc)
        push!(grades_records_array, record)
    end

    return grades_records_array
end

grades_records_array = generate_grades_records_array()

Serde.to_csv(grades_records_array; json_normalize=true) |> println

Serde.SerCsv.ser_value(::Type{GradesRecord}, ::Val{:desc}, x::Desc)::String = Serde.to_json(x)

Serde.to_csv(grades_records_array;) |> println

Serde.to_csv([
           Dict("a" => 10,"B" => 20),
           Dict("a" => 10,"B" => 20),
       ]) |> println


Serde.to_csv([
        Dict("a" => 10,"B" => 20, "C" => Dict(
            "cfoo" => "foo",
            "cbaz" => "baz",
        )),
        Dict(:a => 10, :B => 20),
    ]; json_normalize = true) |> println
