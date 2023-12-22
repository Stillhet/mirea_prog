using HorizonSideRobots
import HorizonSideRobots.move!

r=Robot(animate=true)

function mark_frame_perimetr!(r::Robot)
    
    num_vert = moves!(r, Sud)
    #Мы в левом нижнем углу
    num_hor = moves!(r, West)
    putmarker!(r)
    
    for side in (HorizonSide(i) for i=0:3) #Идем по кругу
        putmarkers!(r, side) 
    end 

    moves!(r, Nord, num_vert)
    #Мы в исходном положении
    moves!(r, Ost, num_hor)
    end
    
    function moves!(r::Robot,side::HorizonSide) #Движение до преграды
        num_steps=0
        while isborder(r,side)==false
            move!(r,side)
            num_steps+=1
        end
        return num_steps #Возвращаем шаги
    end
    
    function moves!(r::Robot,side::HorizonSide,num_steps::Int) #Движемся на "num_steps" шагов
        for _ in 1:num_steps
            move!(r,side)
        end
    end
    
    function putmarkers!(r::Robot, side::HorizonSide) #Пока нет стенки, ставим маркеры
        while isborder(r,side)==false
            move!(r,side)
            putmarker!(r)
        end
    end

