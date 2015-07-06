function colourV = colourVector(colourScalar)
%Détermination de l'état (couleur) dans lequel le robot se trouve.
i=1;%mauve ColorV(10,1) = 1
a =2;%bleu foam ColorV(1,1) = 1
b =3;%bleu pale ColorV(2,1) = 1
c =4;%vert ColorV(3,1) = 1
d =5;%brun foam ColorV(4,1) = 1
e =7;%orange ColorV(5,1) = 1
f =8;%rouge fonce ColorV(6,1) = 1
g =10;%rouge pale ColorV(7,1) = 1
h =6;%jaune foam ColorV(8,1) = 1

%Peut etre devrait-on mettre = variable au lieu de < variable puisqu'il  n'y a plus d'intervale de valeur mais bien une valeur fixe pour chaque etat.
colourV = -ones(10,1);
if colourScalar == i
    colourV(10,1)=1;
elseif colourScalar == a
    colourV(1,1) = 1;
elseif colourScalar == b
    colourV(2,1) = 1;
elseif colourScalar == c
    colourV(3,1) = 1;
elseif colourScalar == d
    colourV(4,1) = 1;
elseif colourScalar == e
    colourV(5,1) = 1;
elseif colourScalar == f
    colourV(6,1) = 1;
elseif colourScalar == g
    colourV(7,1) = 1;
elseif colourScalar == h
    colourV(8,1) = 1;
else
    colourV(9,1) = 1;
end
end