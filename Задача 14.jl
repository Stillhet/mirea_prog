using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function mark_kross!(r::Robot)
    for side in (Nord, West, Sud, Ost)
        num_steps = putmarkers_1!(r,side)
        movements!(r,invers(side), num_steps)
    end
    putmarker!(r)
end

function putmarkers_1!(r::Robot,side::HorizonSide)
    num_steps=0 
    while move_if_possible!(r, side) == true
        putmarker!(r)
        num_steps += 1
    end 
    return num_steps
end
movements!(r::Robot, side::HorizonSide, num_steps::Int) = for _ in 1:num_steps move!(r,side) end

    movements!(r::Robot, side::HorizonSide) = while isborder(r,side)==false move!(r,side) end 

movements!(r::Robot, side::HorizonSide, num_steps::Int) =
for _ in 1:num_steps
    move_if_possible!(r,side)
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = West(direct_side)
    reverse_side = invers(orthogonal_side)
    num_steps=0
    while isborder(r,direct_side) == true
        if isborder(r, orthogonal_side) == false
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end #Робот встречается с преградой и останавливается, или делает один-несколько шагов
    if isborder(r,direct_side) == false
        move!(r,direct_side)
        while isborder(r,reverse_side) == true
            move!(r,direct_side)
        end
        result = true
    else
        result = false
    end
    for _ in 1:num_steps
        move!(r,reverse_side)
    end
    return result
end