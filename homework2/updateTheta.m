function theta = updateTheta(t, E, x)
    theta = t + sum([E{:}]) * x
end