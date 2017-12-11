clear;clc;
%tested for:
% "variables": ["evader@0.0.8", "evader@1", "evader@2", "evader@3", "pursuer@0.0.8", "pursuer@1", "pursuer@2", "pursuer@3"],
%NOTE: CANNOT HAVE WHITESPACE OR TRAILING WHITESPACE
fname='PE_2_08.txt';
fid=fopen(fname,'r');
tline=fgetl(fid);
n=0; j=0;
cont=true;
stateno={};
N=4; %length of binary encode in map
evaPos={}; purPos={};
successors={};
nOffset=1; %offset difference between 0 (entry in SLUGS) and lowest numerical value in map

while cont
    if mod(n,5)==0 %ID #
        j=j+1;
        k=strfind(tline,'"');
        %stateno{j}=str2num(tline(k(1)+1:k(2)-1))+1;
        stateno{j}=j;
    elseif mod(n,5)==1 %rank, ignore
    elseif mod(n,5)==2 %state eva/pur, unpack from binary
        tline2=strsplit(tline);
        tempsum=0;
        for i=3:2+N
            tt=tline2{i}; tt=strrep(tt,'[',''); tt=strrep(tt,',',''); %remove OPEN bracket
            tempsum=tempsum+2^(i-3)*str2num(tt);
            evaPos{j}=tempsum+nOffset;
        end
        tempsum=0;
        for i=3+N:2*N+2
            tt=tline2{i}; tt=strrep(tt,']',''); tt=strrep(tt,',',''); %remove CLOSE bracket
            tempsum=tempsum+2^(i-3-N)*str2num(tt);
            purPos{j}=tempsum+nOffset;
        end
    elseif mod(n,5)==3 %possible successors
        successors{j}=[];
        tline2=strsplit(tline);
        for i=2:length(tline2)
            tt=tline2{i}; tt=strrep(tt,'[',''); tt=strrep(tt,',',''); tt=strrep(tt,']','');
            successors{j}=[successors{j} str2num(tt)+1];
        end
    elseif mod(n,5)==0 %blankline
    end
    
    n=n+1;
    tline=fgetl(fid);
    if tline==-1
        cont=false;
    end
end
fclose(fid);

initializeMap;


