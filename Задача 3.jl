using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function full_marks!(r::Robot) 
    num_vert = get_num_steps_movements!(r, Sud)
    num_hor = get_num_steps_movements!(r, West)#Левый нижний угол

    side = Ost
    mark_row!(r,side) #Идем змейкой и ставим маркеры
    putmarker!(r) #последней маркер в северном углу #Северная граница

    movements!(r,Sud)
    movements!(r, West) #Левый нижний угол

    #Возвращение в первоначальную позицию
    movements!(r,Ost,num_hor)
    movements!(r,Nord,num_vert)
end

#Изменение направления на противоположное
invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4)) 

function mark_row!(r::Robot,side::HorizonSide) #Движение змейкой
    while isborder(r,side) == false #По горизонтали
        putmarker!(r)
        move!(r,side)
    end
    if (isborder(r,Nord) == false) #По вертикали
        putmarker!(r)
        move!(r,Nord)
        side = invers(side::HorizonSide)
        mark_row!(r,side)
    end
end

function get_num_steps_movements!(r::Robot, side::HorizonSide) #без встречи с преградой идём в направлении side и запоминаем кол-во шагов
    num_steps = 0
    while isborder(r, side) == false 
        move!(r,side)
        num_steps += 1
    end
    return num_steps
end

function movements!(r::Robot,side::HorizonSide) #Движение до преграды
    while isborder(r,side) == false
        move!(r,side)
    end
end
function movements!(r::Robot,side::HorizonSide,num_steps::Int) #возвращаемся на num_steps шагов
    for _ in 1:num_steps
        move!(r,side)
    end
end
