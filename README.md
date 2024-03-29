# TStr.jl

This is a [Julia](https://www.julialang.org) package implementing a shorthand
method for creating time constants. A convenience package to supplement the
[Dates](docs.julialang.org/en/v1/stdlib/Dates/) standard library.

## Installation

```julia
import Pkg
Pkg.add(url="https://github.com/GHTaarn/TStr.jl")
```

## Use

```julia
using TStr

t"2024-03-29T15:31" # is equivalent to Dates.DateTime("2024-03-29T15:31")
t"2024-03-29"d # is equivalent to Dates.Date("2024-03-29")
t"20:21:22"t # is equivalent to Dates.Time("20:21:22")
```

More documentation can be obtained using `@doc @t_str`

### Advanced use

By default, only standard time format strings can be used, but it is possible
to use custom time formats if a custom suffix is defined by using the
`TStr.set_t_str_suffix` function, e.g.

```julia
using Dates, TStr

myfunc(s) = Date(s, dateformat"Y u d")
mysuffix = "myformat"
TStr.set_t_str_suffix(mysuffix, myfunc)

@assert t"2024 Feb 29"myformat == Date(2024,2,29)
```
More documentation can be obtained using `@doc TStr.set_t_str_suffix`

## Feedback

Please report bugs and other issues at https://github.com/GHTaarn/TStr.jl/issues or
submit a pull request.
