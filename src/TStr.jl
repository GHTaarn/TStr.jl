module TStr

export @t_str

if VERSION >= v"1.11-"
    eval(Meta.parse("public set_t_str_suffix"))
end

include("core.jl")

end # module TStr
