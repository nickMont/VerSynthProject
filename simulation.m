clear;clc;

slugsParser;
initializeMap;

dk_pur=0;
dk_eva=0;
evaderPlaysNash=1;
pursuerPlaysNash=1;
evaderIsIntelligent=1;  %intelligent if ==1
pursuerUsesOptimal=1; %optimal or nash if ==1

timeToWin=0;
mcmax=10000;
for mcl=1:mcmax
    purPosition=16;
    evaPosition=8;
    %16,8 is a good pair
    
    contvar=true;
    timeStepsToVictory=0;
    while contvar
        timeStepsToVictory=timeStepsToVictory+1;
        purPrev=purPosition;
        if pursuerUsesOptimal==0
            purInd=find([purPos{:}]==purPosition);
            evaInd=find([evaPos{:}]==evaPosition);
            stateIndex=find(purInd==[evaInd(:)]);
            if ~isempty(stateIndex)
                successorInd=randsample(successors{stateIndex},1);
                purPosition=purPos{successorInd};
            end %else purPosition=purPosition
        elseif pursuerPlaysNash==1
            [~,distmat,indP]=optimalMinimaxPath(vn,Ap,Ae,purPosition,evaPosition,1);
            eqP=findNashEq(-distmat,distmat);
            if isempty(eqP)
                probmat=LH2(-distmat,distmat);
                purPosition=randsample(indP,1,true,probmat{1});
            else
                purPosition=indP(eqP(1,1));
            end
        else
            purPosition=optimalMinimaxPath(vn,Ap,Ae,purPosition,evaPosition,dk_pur);
        end
        
        if evaderIsIntelligent==0
            evaVec=zeros(N,1); evaVec(evaPosition)=1;
            evaPossibleLoc=Ae*evaVec;
            evaPossibleInd=find(evaPossibleLoc==1);
            evaPosition=randsample(evaPossibleInd,1);
        elseif evaderPlaysNash==1
            [~,distmat,indE]=optimalMaximinPath(vn,Ap,Ae,purPrev,evaPosition,1);
            eqE=findNashEq(-distmat,distmat);
            if isempty(eqE)
                probmat=LH2(-distmat,distmat);
                evaPosition=randsample(indE,1,true,probmat{2});
            else
                evaPosition=indE(eqE(2,1));
            end
        else
            evaPosition=optimalMaximinPath(vn,Ap,Ae,purPrev,evaPosition,dk_eva);
        end
        
        if minDistBetweenNodes(vn,purPosition,evaPosition)<=1
            contvar=false;
        end
    end
    timeToWin=timeToWin+1/mcmax*timeStepsToVictory;
end
timeToWin


%pur=SLUGS, eva=dk2: 3.3725
%pur=SLUGS, eva=dk1: 3.4823
%pur=SLUGS, eva=ran: 3.2325
%pur=SLUGS, eva=nash: 3.9940
%pur=dk1, eva=dk2: 4.0000
%pur=dk1, eva=dk1: 4.0000
%pur=dk1, eva=ran: 3.0420
%pur=dk1, eva=nash: 3.5030
%pur=dk2, eva=dk2: 2.0000
%pur=dk2, eva=dk1: 2.0000
%pur=dk2, eva=ran: 1.8257
%pur=dk2, eva=nash: 2.0000
%pur=nash, eva=dk2: 4.2100
%pur=nash, eva=dk1: 3.7494
%pur=nash, eva=ran: 2.9781
%pur=nash, eva=nash: 3.3934



