global j h speedmultip
mABj = NXTMotor('AB', 'Power', -round(24*speedmultip), 'TachoLimit', 300);
mABh = NXTMotor('AB', 'Power', -round(27*speedmultip), 'TachoLimit', 300);
mABj.SendToNXT(j);
mABh.SendToNXT(h);
WaitFor(mABh, 900, h);
WaitFor(mABj, 900, j);
NXT_PlayTone(400,300,j)
NXT_PlayTone(500,300,j)