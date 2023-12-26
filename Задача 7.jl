using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function find_hole!(r::Robot, side::HorizonSide, n::Int)
    for _ in 1:n
        move!(r, side)

    end

    if isborder(r, Nord)==true  
        find_hole!(r, invers(side), n+1)
    end

end

invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4))

