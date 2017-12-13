clear;clc;
N=20;
vn=eye(N);
vn(1,2)=1; vn(1,8)=1; vn(1,20)=1;
vn(2,3)=1; vn(2,4)=1;
vn(3,4)=1; vn(3,5)=1;
vn(4,5)=1;
vn(5,6)=1;
vn(6,7)=1; vn(6,8)=1; vn(6,19)=1;
vn(7,8)=1;
vn(8,9)=1; vn(8,10)=1;
vn(9,10)=1;
vn(10,11)=1;
vn(11,12)=1;
vn(12,13)=1; vn(12,14)=1;
vn(14,15)=1;
vn(15,16)=1; vn(15,17)=1;
vn(17,18)=1;
vn(18,19)=1;
vn(19,20)=1;
vn=triu(vn)+triu(vn,1)';  %copy upper triangle to lower triangle

stepsToMove=2;
Aplayer=vn^stepsToMove;
playername='pursuer';

N=length(vn);
for i=1:N
    nodevec=zeros(N,1); nodevec(i)=1;
    possLoc=Aplayer*nodevec;
    indf=find(possLoc>=1);
    
    fprintf('%s = %i -> ',playername,i-1);
    for j=1:length(indf)-1
        fprintf('%s''=%i || ',playername,indf(j)-1);
    end
    fprintf('%s''=%i \n',playername,indf(end)-1);
end


