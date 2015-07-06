global j h speedmultip

b = GetLight(SENSOR_3, j);
c = GetLight(SENSOR_4, j);
    
while (b<320)||(c<320)
    mABj = NXTMotor('AB', 'Power', round(60*speedmultip), 'TachoLimit', 880);
    mABh = NXTMotor('AB', 'Power', round(65*speedmultip), 'TachoLimit', 880);
    mABj.SendToNXT(j);
    mABh.SendToNXT(h);
    WaitFor(mABh, 900, h);
    WaitFor(mABj, 900, j);
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
end

a = GetColor(SENSOR_2, 0, j);
b = GetLight(SENSOR_3, j);
c = GetLight(SENSOR_4, j);

cherchercouleur
xblu = 1;
while a>10 || a == 0
    if xblu < 2
	chercherLigneReverse;
	xblu = xblu+1;
	end
    if b >= 630 && c >= 630
        mABj = NXTMotor('AB', 'Power', round(30*speedmultip));
        mABh = NXTMotor('AB', 'Power', round(35*speedmultip));
        mABj.SendToNXT(j);
        mABh.SendToNXT(h);
    elseif b < 630
        acceleration1 = (-round(33*speedmultip)-round((670-b)*0.8))*(-1);
        if acceleration1 < round(35*speedmultip)
            acceleration1 = round(27*speedmultip);
        end
        mABh = NXTMotor('AB', 'Power', round(15*speedmultip));%il va faloir trouver quelque chose de plus optimal pour que l'acceleration soit proportionnelle au nombre de degrees a faire compenser
		mABj = NXTMotor('AB', 'Power', round(30*speedmultip));
        mABh.SendToNXT(h);
		mABj.SendToNXT(j);
    elseif c < 630
        acceleration2 = (-round(30*speedmultip)-round((650-c)*0.8))*(-1);
        if acceleration2 < round(35*speedmultip)
            acceleration2 = round(27*speedmultip);
        end
        mABj = NXTMotor('AB', 'Power', round(15*speedmultip));%meme chose ici. Par exemple: round(abs((x-c)*quelquechose))
		mABh = NXTMotor('AB', 'Power', round(30*speedmultip));
        mABj.SendToNXT(j);
		mABh.SendToNXT(h);
    end
    pause (0.000)%etait a 0.025
    a = GetColor(SENSOR_2, 0, j);
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
end

pause (0.2)
mABh.Stop('off', h)
mABj.Stop('off', j)