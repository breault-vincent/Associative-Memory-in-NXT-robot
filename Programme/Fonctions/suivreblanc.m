%function suivreblanc()
%j = COM_OpenNXTEx('USB','0016530A5DE9')
%h = COM_OpenNXTEx('USB','0016530A5E6Bacumul');
%OpenLight(SENSOR_3, 'ACTIVE', j)
%OpenLight(SENSOR_4, 'ACTIVE', j)
%OpenColor(SENSOR_2, j)
global j h speedmultip
a = GetColor(SENSOR_2, 0, j);
b = GetLight(SENSOR_3, j);
c = GetLight(SENSOR_4, j);
while (a>10 || a==0) && b>320 && c>320 
    if b >= 630 && c >= 630
        mABj = NXTMotor('AB', 'Power', -round(32*speedmultip));
        mABh = NXTMotor('AB', 'Power', -round(32*speedmultip));
        mABj.SendToNXT(j);
        mABh.SendToNXT(h);
    %elseif b < 630 && c < 630
        %reculerunpeu;
    elseif b < 630 % && c >= 630
        acceleration1 = -33*speedmultip-round((670-b)*0.8);
        if acceleration1 < -round(35*speedmultip)
            acceleration1 = -round(27*speedmultip);
        end
        mABh = NXTMotor('AB', 'Power', -round(30*speedmultip));%il va faloir trouver quelque chose de plus optimal pour que l'acceleration soit proportionnelle au nombre de degrees a faire compenser
		mABj = NXTMotor('AB', 'Power', -round(5*speedmultip));
        mABh.SendToNXT(h);
		mABj.SendToNXT(j);
    elseif c < 630 % &&  b >= 630
        acceleration2 = -30*speedmultip-round((650-c)*0.8);
        if acceleration2 < -round(35*speedmultip)
            acceleration2 = -round(27*speedmultip);
        end
        mABj = NXTMotor('AB', 'Power', -round(30*speedmultip));%meme chose ici. Par exemple: round(abs((x-c)*quelquechose))
		mABh = NXTMotor('AB', 'Power', -round(5*speedmultip));
        mABj.SendToNXT(j);
		mABh.SendToNXT(h);
    end
    pause (0.02)
    a = GetColor(SENSOR_2, 0, j);
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
end
% pause (0.2)
% mABh.Stop('off', h)
% mABj.Stop('off', j)
        
% mABj = NXTMotor('AB', 'Power', -round(40*speedmultip), 'TachoLimit', 20);
% mABh = NXTMotor('AB', 'Power', -round(40*speedmultip), 'TachoLimit', 20);
% mABj.SendToNXT(j);
% mABh.SendToNXT(h);

a = GetColor(SENSOR_2, 0, j);
b = GetLight(SENSOR_3, j);
c = GetLight(SENSOR_4, j);
while (a>10 || a==0) && b>320 && c>320 
    if b >= 630 && c >= 630
        mABj = NXTMotor('AB', 'Power', -round(32*speedmultip));
        mABh = NXTMotor('AB', 'Power', -round(32*speedmultip));
        mABj.SendToNXT(j);
        mABh.SendToNXT(h);
    %elseif b < 630 && c < 630
        %reculerunpeu;
    elseif b < 630 % && c >= 630
        acceleration1 = -round(33*speedmultip)-round((670-b)*0.8);
        if acceleration1 < -round(35*speedmultip)
            acceleration1 = -round(27*speedmultip);
        end
        mABh = NXTMotor('AB', 'Power', -round(30*speedmultip));%il va faloir trouver quelque chose de plus optimal pour que l'acceleration soit proportionnelle au nombre de degrees a faire compenser
		mABj = NXTMotor('AB', 'Power', -round(5*speedmultip));
        mABh.SendToNXT(h);
		mABj.SendToNXT(j);
    elseif c < 630 % && b >= 630
        acceleration2 = -round(30*speedmultip)-round((650-c)*0.8);
        if acceleration2 < -round(35*speedmultip)
            acceleration2 = -round(27*speedmultip);
        end
        mABj = NXTMotor('AB', 'Power', -round(30*speedmultip));%meme chose ici. Par exemple: round(abs((x-c)*quelquechose))
		mABh = NXTMotor('AB', 'Power', -round(5*speedmultip));
        mABj.SendToNXT(j);
		mABh.SendToNXT(h);
    end
    pause (0.0)
    a = GetColor(SENSOR_2, 0, j);
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
end
pause (0.1)
mABh.Stop('off', h)
mABj.Stop('off', j)