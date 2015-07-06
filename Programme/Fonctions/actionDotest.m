function [positionX positionY] = actionDotest(A, positionX, positionY)
if A==1%gauche
        positionX = positionX-1;
    elseif A==2%droite
        positionX = positionX+1;
    elseif A==3%en haut
        positionY = positionY-1;
    else
        positionY = positionY+1;
end