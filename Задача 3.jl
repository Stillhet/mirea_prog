using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4))

function paint_till_border!(r::Robot, side::HorizonSide)
    while isborder(r, side)==false
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)

    if isborder(r, Nord)==false 
    move!(r, Nord)

    paint_till_border!(r, invers(side))
    else 
        while isborder(r, West)==false
            move!(r, West)
        end

        while isborder(r, Sud)==false
            move!(r, Sud)
        end
    end

end #запусти от (r, Ost)
