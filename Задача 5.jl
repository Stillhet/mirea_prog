using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function mark_from_perimetr!(r::Robot)
    steps_up = moves!(r,Nord) #Идем вверх
    steps_left = moves!(r,West) #Идем влево
    steps_down = moves!(r,Sud) #Идем в низ 
    #Мы в левом нижнем углу

    #Робот - в юго-западном углу и в num_steps(пройденный путь)
    side = Nord
    snake!(r,side) #Двигаемся змейкой

   moves!(r,West)
   moves!(r,Sud)

   mark_perimetr!(r)

   movements!(r,Nord, steps_down)
   movements!(r,Ost,steps_left)
   movements!(r,Sud,steps_up)
   # Робот - в исходном положении
end

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


function snake!(r::Robot, side::HorizonSide)
    fl = false
    while (isborder(r,side) == false) #Если сверху или снизу нет преграды - идем туда
        if (isborder(r,Ost)==true) #Если справа преграда
            fl = true
            break
        else #Если преграды нет
            move!(r,side)
        end
    end
    if (fl == false)
        move!(r,Ost)
        side = invers(side)
        snake!(r,side)
    else
        
        while isborder(r, Ost)==true
            move!(r, Sud)
        end
        move!(r, Nord)

        side = Ost #Ходим по кругу
        for way in (Nord, Ost, Sud, West)
            while isborder(r, side) == true && ismarker(r) == false
                putmarker!(r)
                move!(r,way)
            end
            putmarker!(r)
            move!(r,side)
            side = HorizonSide(mod(Int(side) - 1,4))
        end
        
    end
end