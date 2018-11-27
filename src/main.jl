#!/usr/bin/env julia

# add flags: -O3 --compile=all

###
# ordinary differential equation of diffusion:
# ∂Ψ/∂t = D⋅∇²Ψ
# in one dimension:
# ∂Ψ/∂t = D⋅∂²Ψ/∂x²
# ⟹ Ψ = cos(ax)⋅eᵇᵗ such that a = Db

# change to stochastic where ⅊ is noise:
# ∂Ψ/∂t = D⋅∂²Ψ/∂x² + ⅊
# can only be solved analytically, use Runge-Kutta 4 or Euler's method.
###

include.(["h.jl"])

function Ψ(x::Real, t::Real, a=1, b=1, D=1)
    return cos(a*x)*exp(-b*t)
end

Ψ(x, t) = Ψ(x, t, 1, 1, 1) # just setting defaults

function main()

    gr();   # set the plot backend; for publication figures, use pgfplots.
            # GR is a nice quick framework that just works.
    theme(:dark)
    a::Int = 1; # constant in cosine
    b::Int = 1; # constant in exponential
    D::Int = 2; # diffucion constant

    p = contour(
    0:0.001:1,                    # x range
    0:0.001:1,                    # t range
    Ψ,                            # function to evaluate
    fill=true,                    # fill the contours in instead of lines
    aspect_ratio=:equal)          # for a square plot

    display(p)

end

main()
