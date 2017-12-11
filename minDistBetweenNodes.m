function dd = minDistBetweenNodes(V,n1,n2)
%V is the nxn matrix governing node connections
%n1 and n2 are the two nodes to connect
%dd is the number of nodes between them
v1=zeros(length(V));
v1(n1)=1;
contvar=true;
dd=0;
if n1~=n2
    while contvar
        dd=dd+1;
        v1=V*v1;
        if v1(n2)>=1
            contvar=false;
        elseif dd>1000
            contvar=false;
        end
    end
end

end

