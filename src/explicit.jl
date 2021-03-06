##############################################
#  ________________________________________  #
# /  DO WHAT THE FUCK YOU WANT TO PUBLIC   \ #
# | LICENSE                                | #
# |                                        | #
# | Version 2, December 2004               | #
# |                                        | #
# | Copyright (C) 2018 Anshul Singhvi      | #
# | <asinghvi17@simons-rock.edu>           | #
# |                                        | #
# | Everyone is permitted to copy and      | #
# | distribute verbatim or modified copies | #
# | of this license document, and changing | #
# | it is allowed as long as the name is   | #
# | changed.                               | #
# |                                        | #
# | DO WHAT THE FUCK YOU WANT TO PUBLIC    | #
# | LICENSE                                | #
# |                                        | #
# | TERMS AND CONDITIONS FOR COPYING,      | #
# | DISTRIBUTION AND MODIFICATION          | #
# |                                        | #
# | 0. You just DO WHAT THE FUCK YOU WANT  | #
# \ TO.                                    / #
#  ----------------------------------------  #
#         \   ^__^                           #
#          \  (oo)\_______                   #
#             (__)\       )\/\               #
#                 ||----w |                  #
#                 ||     ||                  #
##############################################
include.(["h.jl"])

function doVariableDirichlet(
    # DEFAULT ARGS
    xm,        # the max position (position goes from 0 to sm)
    Δx,        # the space step
    tm,        # the max time (time goes from 0 to tm)
    Δt,        # the time step
    b;         # the initial distribution
    # KWARGS
    Tl = 10,           # the temperature on the leftmost node, a Dirichlet boundary condition
    Tr = 10,           # the temperature on the rightmost node, a Dirichlet boundary condition
    anim_func = Plots.gif
    )

    nx = length(0:Δx:xm)         # the dimension of the matrix

    # THe definition of the A matrix is now complete.

    # Now, we can proceed to defining the vectors.
    # x is the vector of temperatures at time=n+1
    # b is the vector of temperatures at time=n.


    anim = @animate for i ∈ 0:Δt:tm
        for i ∈ 2:length(b)-1
            x[i].T = (1-2*b[i].D*Δt/Δx^2)*b[i].T + b[i+1].D*Δt/Δx^2*b[i+1].T + b[i-1].D*Δt/Δx^2*b[i-1].T
        end
        x[1].T   = b[1].T
        x[end].T = b[end].T
        b = x
        p = scatter(
        0:Δx:xm, b,
        title = "t=$(string(i)[1:min(end, 4)])",
        xlabel="x",
        ylabel="T",
        # ylims = (0, max(Tl, Tr) + 1)
        )
    end

    p = anim_func(anim, "lol", fps=30)

end

b = [Block(0, 0.01) for i ∈ 1:nx]

b[]

doVariableDirichlet()
