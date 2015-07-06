%function tourner()
global h j
%x=2.50
mABh = NXTMotor('AB', 'Power', -35);%, 'TachoLimit',round(90*x)); %Action 2: Droite
mABj = NXTMotor('AB', 'Power', 35);%, 'TachoLimit',round(90*x));
mABh.SendToNXT(h);
mABj.SendToNXT(j);
pause(0.8)
lignes = 0;
while lignes < 2
    b = GetLight(SENSOR_3, j);
    if lignes == 0
        if b < 630
            lignes = lignes+1;
            pause (1)
        end
    end
    if lignes == 1
        b = GetLight(SENSOR_3, j);
        if b < 630
            lignes = lignes+1;
        end
    end
end
pause (0.0)
mABh.Stop('off', h)
mABj.Stop('off', j)


    
%20% de la puissance est pas suffisant pour faire bouger les roues. 30%
%fait bouger mais manque d'efficacite