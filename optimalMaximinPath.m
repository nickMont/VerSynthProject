function pathVec = optimalMaximinPath(vn,Apur,Aeva,nPur,nEva,dk_max)
%value is considered val=N-dist(nPur,nEva)
%returns the path such that max_pur(min_eva(val)) for dk_max time steps
vp=zeros(length(vn),1); vp(nPur)=1;
ve=zeros(length(vn),1); ve(nEva)=1;

mindist=length(vn);
bestpath=[];
if dk_max==1
    vp2=Apur*vp;
    ve2=Aeva*ve;
    indp=find(vp2>=1);
    inde=find(ve2>=1);
    distmat=zeros(length(indp),length(inde));
    for i1=1:length(indp)
        for i2=1:length(inde)
            distmat(i1,i2)=minDistBetweenNodes(vn,indp(i1),inde(i2));
        end
    end
    [~,ind]=min(max(distmat'));
    bestpath=indp(ind);
end

pathVec=bestpath;

end

