## Serde.jl changelog

The latest version of this file can be found at the master branch of the [Serde.jl](https://gitlab.com/bhft/Serde.jl) repository.

### 0.1.1 (2023-20-04) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/10))

#### Fixed (1 change)

- Bug with deserialization `AbstractString`'s [issue](https://gitlab.com/bhft/Serde.jl/-/issues/9)

### 0.1.2 (2023-21-04) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/11))

#### Fixed (1 change)

- WrongType error refactoring

### 0.1.3 (2023-21-04) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/12))

#### Fixed (1 change)

- Generalization `AbstractFloat` and `Integer`
- Deserialization `AbstractString` to `Number`

### 0.2.0 (2023-27-04) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/15))

#### Added (1 change)

- function `Serde.to_pretty_json()`

#### Changed (1 change)

- Make Serialization in Json with IOBuffer

### 0.2.2 (2023-23-05) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/20))

#### Changed (1 change)

- Accelerate json serialization (`NamedTuple`, `Dict`, `String`, `Symbol`) [issue](https://gitlab.com/bhft/Serde.jl/-/issues/17)

### 0.2.3 (2023-29-05) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/19))

#### Added (2 changes)

- Query parser, function `ParQuery.parse()`
- Query deser, function `Serde.deser_query()`

#### Changed (1 change)

- Ser for vectors in queries `a=[1,2,3] => a=[1,2,3]`

#### Fixed (1 change)
- Dates in `CHANGELOG.md`

### 0.2.4 (2023-3-06) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/22))

#### Fixed (1 change)
- Bug with long `NamedTuple` [issue](https://gitlab.com/bhft/Serde.jl/-/issues/18)

### 0.2.5 (2023-5-06) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/23))

#### Fixed (1 change)
- Bug with long deserialization array with `nothing`'s to `Struct` [issue](https://gitlab.com/bhft/Serde.jl/-/issues/19)

### 0.2.6 (2023-8-06) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/24))

#### Changed (1 change)
- New interface prepare_query for SerQuery

### 0.2.7 (2023-28-06) ([merge request](https://gitlab.com/bhft/Serde.jl/-/merge_requests/28))

#### Fixed (1 change)
- Fixed SerToml for Dicts