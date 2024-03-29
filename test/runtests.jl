using Dates, Test
using TStr

@testset "t_str" begin
    @test t"2024-01-02T03:04" == DateTime(2024,1,2,3,4)
    @test t"2000-02-29"d == Date(2000,2,29)
    @test t"19:20"t == Time(19,20)
    @test t"1970-01-01T00:01"u == 60
end

@testset "set_t_str_suffix" begin
    myfunc(s) = Date(s, dateformat"Y u d")
    mysuffix = "myformat"
    TStr.set_t_str_suffix(mysuffix, myfunc)
    @test_throws ErrorException TStr.set_t_str_suffix(mysuffix, myfunc)

    @test t"2024 Feb 29"myformat == Date(2024,2,29)
    TStr.set_t_str_suffix(mysuffix, nothing)
    @test_throws KeyError t"2024 Feb 29"myformat
end

@testset "ZonedDateTime" begin
    @test_throws KeyError t"2020-11-11T11:11:11.111Z"z
    eval(Meta.parse("using TimeZones"))
    if VERSION >= v"1.9.0-"
        @test t"2020-11-11T11:11:11.111Z"z == ZonedDateTime("2020-11-11T11:11:11.111Z")
    end
end
