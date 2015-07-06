function [W V] = BAMRlLearning8(nbIter, reinf)
%BAMRlLearning est une fonction d'apprentissage à l'aide d'un BAM et de
%reinforcement learning. Sa tâche est, tout d'abord, d'explorer son
%environement afin de d'associer une couleur,une orientation et une action
%à une nouvelle couleur, une nouvelle orientation et un reward. Pour la
%phase d'exploitation, son but est d'atteindre une certaine couleur avec le
%plus grand reward.
%   Le seul argument d'entré est le nombre d'itérations que le robot devra
%   effectuer lors de son exploration. Pour ce qui est des arguments de
%   sortie, il s'agit des deux matrices W et V de poids du BAM.

OuvrirNXT
%Calibrationducompas (Nécessaire uniquement si le design du robot change, une fois)
%W = randn(40)*0.1;
%V = randn(40)*0.1; %Initialisation des matrices de poids de connexion pour le BAM
W = zeros(40);
V = zeros(40);
eta = .1; %Paramètre d'apprentissage du BAM
delta = .5;
global h j 
[Xall Yall Ux Sx Vx Uy Sy Vy] = allPossibleInputs3();
%Calibration de la position nord-sud
%orient = GetCompass(SENSOR_1, h); pas utilisé
%diff.orient = 360 - orient; pas utilisé
NET.addAssembly('System.Windows.Forms'); %Pour monitorer le battery life pour pas que sa meurt en plein millieux
powerStatus = System.Windows.Forms.SystemInformation.PowerStatus;
superColourV = zeros(nbIter,1);
superRewardV = zeros(nbIter,1);
ErrorX = zeros(nbIter, 1);
ErrorY = zeros(nbIter, 1);
for i=1:nbIter
    NXT_SendKeepAlive('dontreply', h);%pour empecher la brique de se fermer en plein millieur du test...
    NXT_SendKeepAlive('dontreply', j);
    if mod(i,1) == 0
        savefile = ['WV' num2str(i) 'iter.mat'];
        save(savefile)
    end
    if powerStatus.BatteryLifePercent < 0.2
        %sortir = 1
        disp('Battery life critical, please plug in computer')
        while powerStatus.BatteryLifePercent < 0.9; %&& sortir == 1;
            %sortir = input('Please input a number above one to stop chargin before 90%')
            NXT_SendKeepAlive('dontreply', h);%pour empecher la brique de se fermer en plein millieur du test...
            NXT_SendKeepAlive('dontreply', j);
        end
        input('Please press the return key when the power cord is unplugged')
        OuvrirNXT
        disp('Starting up again')
    end
    %if mod(i,100) == 0 
	 %   NXT_Playtone(i+100, 300, j);
    %end;
	colourScalar1=GetColor(SENSOR_2, 0, j);
    colourV1=colourVector(colourScalar1);
        
    compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
    compassV1 = compassVector(compassScalar); %pas utilisé
    
    A=randi(4);
    ActionV = -ones(4,1);
    ActionV(A,1)=1; %D'une action scalaire (1 à 4) à un vecteur bipolaire 4x1
    actionDo(A,compassScalar);
    superColourV(i,1) = A;
    
    colourScalar2=GetColor(SENSOR_2, 0, j);
    colourV2=colourVector(colourScalar2);
    superColourV(i, 1) = colourScalar2;
    %% Lecture de la deuxième orientation
    compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
    compassV2 = compassVector(compassScalar); %pas utilisé
    %% Robot recule s'il sort de l'environnement et détemrination du Reward
	%!!!
    %coul = GetColor(SENSOR_2, 0, j);
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
    if (b<320)||(c<320) % || coul==0
        reculer
        %reculerunpeu;
		%turnaroundmur
		%suivreblanc
		%mAB = NXTMotor('AB', 'Power', 40, 'TachoLimit', 630);
        %mAB.SendToNXT(h);
		%mAB.SendToNXT(j);
        %mAB.WaitFor(j);
		%mAB.WaitFor(h);
        Reward=-ones(4,1);         
    elseif colourV2(reinf,1)==1 %Max Reward si la couleur est gagnante
        Reward=ones(4,1);
    else %Reward de 2 sur les autres cases
        Reward=-ones(4,1);
        Reward(1:2,1)=1;
    end
    %!!!
    %% Détermination des inputs X et Y pour le BAM
    X = vertcat(colourV1,ActionV); %Input X du BAM
    Y = vertcat(colourV2,Reward); %Input Y du BAM
    XPosition=find(all(repmat(X,1,size(Xall,2))==Xall)); %Trouve la ieme colonne où se trouve le vecteur X dans Xall
    YPosition=find(all(repmat(Y,1,size(Yall,2))==Yall)); %Trouve la ieme colonne où se trouve le vecteur Y dans Yall
    
    XBAM=Ux(XPosition,:);%Vecteur X orthogonalisé pour facilité l'apprentissage dans le BAM
    YBAM=Uy(YPosition,:);%Vecteur Y orthogonalisé pour facilité l'apprentissage dans le BAM
    
    [W V X1 Y1] = BAM(XBAM, YBAM, W, V, eta, delta); %Apprentissage à l'aide d'un BAM
    ErrorX(i, 1) = norm(XBAM-(X1./norm(X1))');
    ErrorY(i, 1) = norm(YBAM-(Y1./norm(Y1))');
    
end
%% Pause entre la phase d'exploration et d'exploitation
pause(5);
%% Phase d'exploitation (prévision future à l'aide de 3 BAM)
superColourVExploit = zeros(100, 1);
colourScalar=GetColor(SENSOR_2, 0, j);
colourV1 = colourVector(colourScalar);
superColourVExploit(1, 1) = colourScalar;
historique = 1;
while colourV1(reinf,1) ~= 1
    Rsequencelist=[];
    colourScalar=GetColor(SENSOR_2, 0, j);
    colourV1 = colourVector(colourScalar);
    compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
    compassV1 = compassVector(compassScalar);
    
    for i = 1:4
        for jj = 1:4
            for k = 1:4
                ActionV1 = -ones(4,1);
                ActionV1(i,1)=1;
                X1=vertcat(colourV1,ActionV1);
                XPosition=find(all(repmat(X1,1,size(Xall,2))==Xall));
                Xin1=Ux(XPosition,:);%Orthogonalisation du vecteur d'entrée
                [Xout1 Yout1 colourV1out ActionV1out colourV2out R1out] = BAMout2(Xin1,W,V,5,0.5);
                
                for m=1:40
                    DifList(1,m)=norm(Yout1./norm(Yout1)-Uy(m,:)');
                end
                [Valeur YPosition]= min(DifList);
                Yvector1=Yall(:,YPosition);% Désorthogonalisation du vecteur de sortie
                
                ActionV2 = -ones(4,1);
                ActionV2(jj,1)=1;
                
                X2 = vertcat(Yvector1(1:10,1),ActionV2);%Création du vecteur d'entré pour le 2e BAM
                XPosition=find(all(repmat(X2,1,size(Xall,2))==Xall));
                Xin2=Ux(XPosition,:);%Orthogonalisation du vecteur d'entré
                [Xout2 Yout2 colourV2out ActionV2out colourV3out R2out] = BAMout2(Xin2,W,V,5,0.5);
                
                
                for m=1:40
                    DifList(1,m)=norm(Yout2./norm(Yout2)-Uy(m,:)');
                end
                [Valeur YPosition]= min(DifList);
                Yvector2=Yall(:,YPosition);
                
                ActionV3 = -ones(4,1);
                ActionV3(k,1)=1;
                
                X3 = vertcat(Yvector2(1:10,1),ActionV3);
                XPosition=find(all(repmat(X3,1,size(Xall,2))==Xall));
                Xin3=Ux(XPosition,:);
                
                [Xout3 Yout3 colourV3out ActionV3out colourV4out R3out] = BAMout2(Xin3,W,V,5,0.5);
                
                for m=1:40
                    DifList(1,m)=norm(Yout2./norm(Yout2)-Uy(m,:)');
                end
                [Valeur YPosition]= min(DifList);
                Yvector3=Yall(:,YPosition);
                
                R1out  = Yvector1(11:14,1);
                R2out = Yvector2(11:14,1);
                R3out = Yvector3(11:14,1);
                
                if sum(R1out)==-4 || sum(R2out)==-4 || sum(R3out)==-4
                    Rsequence=[-Inf -Inf -Inf];
                else
                    Rsequence=[sum(R1out) sum(R2out) sum(R3out)]; % Création du vecteur contenant les 3 rewards prévus
                end
                
                Rsequencelist=[Rsequencelist;Rsequence];
                
            end
        end
    end
    %% Sélection de la séquence d'actions à poser
    Z=actCubT(0.1*Rsequencelist*[0.8;0.8^2;0.8^3],delta)';
    [WinnerZ indiceWinnerZ]=max(Z);
    MatriceAction=[1 1 1; 1 1 2; 1 1 3; 1 1 4; 1 2 1; 1 2 2; 1 2 3; 1 2 4; 1 3 1; 1 3 2; 1 3 3; 1 3 4; 1 4 1; 1 4 2; 1 4 3; 1 4 4;
        2 1 1; 2 1 2; 2 1 3; 2 1 4; 2 2 1; 2 2 2; 2 2 3; 2 2 4; 2 3 1; 2 3 2; 2 3 3; 2 3 4; 2 4 1; 2 4 2; 2 4 3; 2 4 4;
        3 1 1; 3 1 2; 3 1 3; 3 1 4; 3 2 1; 3 2 2; 3 2 3; 3 2 4; 3 3 1; 3 3 2; 3 3 3; 3 3 4; 3 4 1; 3 4 2; 3 4 3; 3 4 4;
        4 1 1; 4 1 2; 4 1 3; 4 1 4; 4 2 1; 4 2 2; 4 2 3; 4 2 4; 4 3 1; 4 3 2; 4 3 3; 4 3 4; 4 4 1; 4 4 2; 4 4 3; 4 4 4];
    
    ActSeq=MatriceAction(indiceWinnerZ,:);
    
    compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
    actionDo(ActSeq(1,1),compassScalar);
    colourScalar=GetColor(SENSOR_2, 0, j);
    colourV1 = colourVector(colourScalar);
    historique = historique+1;
    superColourVExploit(historique, 1) = colourScalar;
    b = GetLight(SENSOR_3, j);
    c = GetLight(SENSOR_4, j);
    
    if (colourV1(reinf,1) ~= 1) && (b>320)&&(c>320)
        compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
        actionDo(ActSeq(1,2), compassScalar);
        colourScalar=GetColor(SENSOR_2, 0, j);
        colourV1 = colourVector(colourScalar);
        b = GetLight(SENSOR_3, j);
        c = GetLight(SENSOR_4, j);
        historique = historique+1;
        superColourVExploit(historique, 1) = colourScalar;
    end
    if (colourV1(reinf,1) ~= 1) && (b>320)&&(c>320)
        compassScalar=GetCompass(SENSOR_1, h);%+diff.orient;
        actionDo(ActSeq(1,3), compassScalar);
        colourScalar=GetColor(SENSOR_2, 0, j);
        colourV1 = colourVector(colourScalar);
        b = GetLight(SENSOR_3, j);
        c = GetLight(SENSOR_4, j);
        historique = historique+1;
        superColourVExploit(historique, 1) = colourScalar; 
    end
    
    if (b<320)&&(c<320)
        reculer;  
    end
end