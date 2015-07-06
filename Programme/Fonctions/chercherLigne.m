global h j speedmultip
x=2.50;
a = GetColor(SENSOR_2, 0, j);
c = GetLight(SENSOR_4, j);
b = GetLight(SENSOR_3, j);
if a>10 || a == 0
mABh = NXTMotor('AB', 'Power', -round(35*speedmultip), 'TachoLimit',round(25*x), 'SmoothStart', true); %J'ai réduit la vitesse parce qu'il partait trop vite et ça le rendait croche
mABj = NXTMotor('AB', 'Power', round(35*speedmultip), 'TachoLimit',round(25*x),'SmoothStart', true);%
mABh.SendToNXT(h);
mABj.SendToNXT(j);

data = mABh.ReadFromNXT(h);
c = GetLight(SENSOR_4, j);
  while(data.IsRunning) && c>630
      c = GetLight(SENSOR_4, j);
      data = mABh.ReadFromNXT(h); % refresh
  end
  
if c<=630
    NXT_PlayTone(200, 200, j);
    mABh.Stop('Brake', h);
    mABj.Stop('Brake', j)
	mABh.Stop('off', h);
    mABj.Stop('off', j);
else
    WaitFor(mABh, 900, h);
    WaitFor(mABj, 900, j);
    
    mABh = NXTMotor('AB', 'Power', round(36*speedmultip), 'TachoLimit',round(50*x), 'SmoothStart', true); %Action 2: Droite
    mABj = NXTMotor('AB', 'Power', -round(36*speedmultip), 'TachoLimit',round(50*x), 'SmoothStart', true);
    mABh.SendToNXT(h);
    mABj.SendToNXT(j);
    
    data = mABh.ReadFromNXT(h);
    b = GetLight(SENSOR_3, j);
    while(data.IsRunning) && b>630
        b = GetLight(SENSOR_3, j);
        data = mABh.ReadFromNXT(h); % refresh
    end
    
    NXT_PlayTone(200, 200, j);
    mABh.Stop('Brake', h);
    mABj.Stop('Brake', j)
	mABh.Stop('off', h);
    mABj.Stop('off', j);
end
end