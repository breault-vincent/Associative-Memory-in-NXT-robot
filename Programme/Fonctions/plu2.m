    Error=zeros(36,1);
    indicetest=1;
    for ir = 1:9
        for jv = 1:4            
            colourScalar=ir;
            colourV1=colourVector(colourScalar);
            if ir == 9;
                irr = 10;
                colourScalar=irr;
                colourV1=colourVector(colourScalar);
            end
            ActionV1 = -ones(4,1);
            ActionV1(jv,1)=1;
            X1=vertcat(colourV1,ActionV1);
            XPosition=find(all(repmat(X1,1,size(Xall,2))==Xall));
            Xin1=Ux(XPosition,:);
            [Xout1 Yout1 colourV1out ActionV1out colourV2out R1out] = BAMout2(Xin1,W,V,5,0.5);
            [Xout1 YoutVrai colourV1out ActionV1out colourV2out R1out] = BAMout2(Xin1,W1,V1,5,0.5);
            Error(indicetest, 1)= norm((YoutVrai./norm(YoutVrai))-(Yout1./norm(Yout1)));
            indicetest=indicetest+1;
        end
    end
superErrorY(i, 1)=mean(Error);