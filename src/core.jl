using Dates

"""
This [`Dict`](@ref) maps the suffix from the [`@t_str`](@ref) macro
to the corresponding function that must be executed.
"""
const t_str_suffixes = Dict{AbstractString, Any}(
    "d" => Date,
    "t" => Time,
    "u" => datetime2unix ∘ DateTime,
    "" => DateTime)

"""
    set_t_str_suffix(suffix::AbstractString, constructor)

Create a custom suffix for the macro [`@t_str`](@ref).
Throws an [`error`](@ref) if the suffix already exists.
If `constructor == nothing` the suffix is deleted.
Deleting suffixes defined in foreign code can have consequences that are
difficult to predict and should therefore normally not be done.

## Example
```julia
using Dates, TStr

myfunc(s) = Date(s, dateformat"Y u d")
mysuffix = "myformat"
TStr.set_t_str_suffix(mysuffix, myfunc)

@assert t"2024 Feb 29"myformat == Date(2024,2,29)
```
"""
function set_t_str_suffix(suffix::AbstractString, constructor)
    constructor == nothing && return delete!(t_str_suffixes, suffix)
    haskey(t_str_suffixes, suffix) && error("Flag $suffix already exists")
    t_str_suffixes[suffix] = constructor
end

"""
    @t_str(str,suffix)

A shorthand method for specifying a time constant, especially subtypes of
[`TimeType`](@ref).
When `suffix` is the empty string a [`DateTime`](@ref) object is
created, if `suffix` is "d" then a [`Date`](@ref) object is created
and if `suffix` is "t" then a [`Time`](@ref) object is created.
When `suffix` is "u" then the corresponding Unix time is returned.

Custom suffixes can be created with [`set_t_str_suffix`](@ref)

# Example

```julia-repl
julia> using Dates, TStr

julia> t"2020-12-31T15:16:17.18" === DateTime("2020-12-31T15:16:17.18")
true

julia> t"2020-12-31"d === Date("2020-12-31")
true

julia> t"15:16:17.18"t === Time("15:16:17.18")
true

julia> t"1970-01-01T00:01"u === datetime2unix(DateTime("1970-01-01T00:01"))
true

```
"""
macro t_str(str, suffix="")
    :($t_str_suffixes[$suffix]($str))
end

