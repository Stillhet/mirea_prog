using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function paint_till_border!(r::Robot, side::HorizonSide)
    while isborder(r, side)==false
        putmarker!(r)
        move!(r, side)
    end
    
end

function mark_perimetr!(r::Robot)
    for side in (Nord, Ost, Sud, West)
        paint_till_border!(r, side)
    end
    

end
