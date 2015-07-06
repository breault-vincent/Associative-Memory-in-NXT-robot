function [Xall Yall Ux Sx Vx Uy Sy Vy] = allPossibleInputs2()
%% Defining all possible inputs and their singular value decomposition.
% (From inputs X, Y, to orthogonalized inputs Ux, Uy)

% Each x (input) is a column of X, Each y is a column of Y, Each u (input
% after orthogonalization) is a column of U

% U, S and V are kept in their original form (not transposed)

%% Defining all possible "x"
light = -ones(10,10)+2.*eye(10);
light = horzcat(light,light,light,light);

action = -ones(4,40);
action(1,1:10) = 1;
action(2,11:20) = 1;
action(3,21:30) = 1;
action(4,31:40) = 1;

Xall = vertcat(light, action);
[Ux,Sx,Vx] = svd(Xall');
Ux = Ux';

%% Defining all possible "y"
R = -ones(4,40);
R(1,1:10) = -1;
R(1:2,11:20) = 1;
R(1:3,21:30) = 1;
R(1:4,31:40) = 1;

Yall = vertcat(light,R);
[Uy,Sy,Vy] = svd(Yall');
Uy =Uy';
end