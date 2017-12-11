%node transitions
N=9;
vn=eye(N);
vn(2,1)=1; vn(1,2)=1; vn(1,7)=1; vn(7,1)=1;
vn(2,3)=1; vn(3,2)=1;
vn(3,4)=1; vn(4,3)=1;
vn(4,5)=1; vn(5,4)=1; vn(4,9)=1; vn(9,4)=1; vn(4,6)=1; vn(6,4)=1;
vn(6,7)=1; vn(7,6)=1;
vn(7,8)=1; vn(8,7)=1;

%Number of steps to take per node 
n_pur=2;
n_eva=1;

Ap=vn^n_pur;
Ae=vn^n_eva;

%Elements of Ae/Ap denote number of paths from Col# to Row#.  We want this
%to be either 1 (path exists in one time step) or 0 (no path exists in
%one time step)
for i=1:N
    for j=1:N
        if Ap(i,j)>1
            Ap(i,j)=1;
        end
        if Ae(i,j)>1
            Ae(i,j)=1;
        end
    end
end