global h j speedmultip
x=2.50;
a = GetColor(SENSOR_2, 0, j);
if a>10 || a == 0
mABh = NXTMotor('AB', 'Power', -round(35*speedmultip), 'TachoLimit',round(25*x)); 
mABj = NXTMotor('AB', 'Power', round(35*speedmultip), 'TachoLimit',round(25*x));
mABh.SendToNXT(h);
mABj.SendToNXT(j);

data = mABh.ReadFromNXT(h);
a = GetColor(SENSOR_2, 0, j);
  while(data.IsRunning) && (a>10 || a == 0)
      a = GetColor(SENSOR_2, 0, j);
      data = mABh.ReadFromNXT(h); % refresh
  end
  
if a<10 && a ~= 0
    NXT_PlayTone(200, 200, j);
    mABh.Stop('off', h);
    mABj.Stop('off', j);
else
    WaitFor(mABh, 900, h);
    WaitFor(mABj, 900, j);
    
    mABh = NXTMotor('AB', 'Power', round(36*speedmultip), 'TachoLimit',round(50*x)); %Action 2: Droite
    mABj = NXTMotor('AB', 'Power', -round(36*speedmultip), 'TachoLimit',round(50*x));
    mABh.SendToNXT(h);
    mABj.SendToNXT(j);
    
    data = mABh.ReadFromNXT(h);
    a = GetColor(SENSOR_2, 0, j);
    while(data.IsRunning) && (a>10 || a == 0)
        a = GetColor(SENSOR_2, 0, j);
        data = mABh.ReadFromNXT(h); % refresh
    end
    
    NXT_PlayTone(200, 200, j);
    mABh.Stop('off', h);
    mABj.Stop('off', j);
end
end