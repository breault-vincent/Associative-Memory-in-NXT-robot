%function tourner()
global h j speedmultip
%x=2.50
mABh = NXTMotor('AB', 'Power', -round(35*speedmultip));%, 'TachoLimit',round(90*x)); %Action 2: Droite
mABj = NXTMotor('AB', 'Power', round(35*speedmultip));%, 'TachoLimit',round(90*x));
mABh.SendToNXT(h);
mABj.SendToNXT(j);
pause(1)
b = GetLight(SENSOR_3, j);
while b > 630
    b = GetLight(SENSOR_3, j);
end
pause (0.0)
mABh.Stop('off', h)
mABj.Stop('off', j)


    
%20% de la puissance est pas suffisant pour faire bouger les roues. 30%
%fait bouger mais manque d'efficacite