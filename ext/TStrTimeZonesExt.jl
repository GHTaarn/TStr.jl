module TStrTimeZonesExt

using TimeZones: ZonedDateTime
using TStr

function __init__()
    try
        TStr.set_t_str_suffix("z", ZonedDateTime)
    catch e1
        @warn "Loading of package extension failed" e1
    end
end

end # module TStrTimeZonesExt
