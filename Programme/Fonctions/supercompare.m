difflist=[];
for i=1:200;
    [W V ErrorX ErrorY superColourV superReward superErrorY] = BAMRlLearning9test(10*i, 7, W_compare, V_compare);
    for posX = 2:4;
        for posY = 2:4;
            [someValue] = BAMRlExploittest2_continue(W, V, 7, posX, posY);
            nbr_mvmnt = size(someValue);
            [someValue2] = BAMRlExploittest2_continue(W_compare, V_compare, 7, posX, posY);
            nbr_mvmnt_cool = size(someValue2);
            diff = nbr_mvmnt-nbr_mvmnt_cool;
            extra_tiles = setdiff(someValue,someValue2);
            difflist = [difflist;diff];
        end
    end
end