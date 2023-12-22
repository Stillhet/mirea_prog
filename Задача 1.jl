using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

 function mark_kross!(r::Robot)     #Основная функция 
    for side in (Nord,West,Sud,Ost) #Идем во все стороны света
        num_steps=get_num_steps_putmarkers!(r,side) #Закрепление числа шагов
        movements!(r,invers(side),num_steps) #Возвращение в исходную
    end
    putmarker!(r) #Ставим маркеры
end

invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4)) #Меняем направление на противоположное 

function get_num_steps_putmarkers!(r::Robot,side::HorizonSide) #Идем в side и запоминаем шаги
    num_steps=0
    while isborder(r, side) == false #Пока не встретил преграду
        move!(r,side)
        putmarker!(r)
        num_steps += 1 
    end
    return num_steps #Возвращаем число шагов
end

movements!(r::Robot,side::HorizonSide,num_steps::Int) = #Движ
    for _ in 1:num_steps 
        move!(r,side)
    end


