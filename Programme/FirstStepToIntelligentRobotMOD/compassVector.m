function compassV = compassVector(compassScalar)
%Détermination de la direction dans laquelle le robot regarde
% Nord, Est, Sud, Ouest

compassV = -ones(4,1);

if compassScalar>315 || compassScalar<=45
    compassV(1,1) = 1; %Nord
elseif compassScalar>45 && compassScalar<=135
    compassV(2,1) = 1; %Est
elseif compassScalar>135 && compassScalar<=225
    compassV(3,1) = 1; %Sud
else
    compassV(4,1) = 1; %Ouest
end

end