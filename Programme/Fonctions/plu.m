bluX = zeros(36, 14);
bluY = zeros(36, 14);
hist = 1;
%for ir = 1:9
     for jv = 1:4
         colourScalar=10;
         colourV1=colourVector(colourScalar);
         ActionV1 = -ones(4,1);
         ActionV1(jv,1)=1;
         X1=vertcat(colourV1,ActionV1);
         XPosition=find(all(repmat(X1,1,size(Xall,2))==Xall));
         Xin1=Ux(XPosition,:);
         [Xout1 Yout1 colourV1out ActionV1out colourV2out R1out] = BAMout2(Xin1,W,V,5,0.5);
         for m=1:40
                DifList(1,m)=norm(Yout1./norm(Yout1)-Uy(m,:)');
         end
         [Valeur YPosition]= min(DifList);
         Yvector1=Yall(:,YPosition);
         X1=X1';
         Yvector1=Yvector1';
         bluX(hist, :) = X1;
         bluY(hist, :) = Yvector1;
         hist = hist+1;
end
%end