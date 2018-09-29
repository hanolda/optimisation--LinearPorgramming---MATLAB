clc;
clear;
clear workspace;
%% Problem 2.3
% maximize      2x1 ? 6x2
% subject to    ?x1 ? x2 ? x3 ? ?2
%               2x1 ? x2 + x3 ? 1
%               x1, x2, x3 ? 0 .


%% Linear Programming: Problem definition

m=2;n=3;
A=[-1 -1 -1; 2 -1 1];
A=[A eye(m)];
b=[-2;1];
c=[2;-6];            % objective function coefficients
c=[c;zeros(m,1)];

if any(c<0)
    % introduce x0
    A0= A;
    A0(:,end+1)=-1;
    A = A0;
    c0= [zeros(m+n)-1];
    c=c0;
end

% ======== 1A  ========
% B={3,4,5} - bas = indexes of nonbasic variables
% N={1,2} - nbas = indexes of basic variables
bas=n+1:m+n;
nbas=1:n;

B = A(:,bas);
N = A(:, nbas);

cB = c(bas,:);
cN = c(nbas,:);

% xb = B^(-1)*b -  initial basic variables
xB = inv(B)*b;

% zn = (B^(-1)*N)'*cB-cN - initial nonbasic dual variableS
zN = (inv(B)*N).'*cB-cN;

%sulution representation
iteration{1,1} = 'xB';
iteration{1,2} = 'zN';
iteration{1,3} = 'nbas';
iteration{1,4} = 'bas';
iteration{1,5} = 'ObjFunc';
iteration{1,6} = 'Optimal';

%% ======= RUN SIMPLEX =======
it=1;   % iteration
nonOptimal = 'True';
runn = 'True';
while runn
    runn
    [xBout, zNout, nbasout, basout, Bout, Nout, ObjFunc, runn] = funcSimplex3(  xB, zN, nbas, bas, B, N, A, b, c) ;
    it =it+ 1;
    
    xB = xBout
    zN = zNout
    nbas = nbasout;
    bas = basout;
    B = Bout;
    N = Nout;
    
    %sulution representation
    iteration{it,1} = xB;
    iteration{it,2} = zN;
    iteration{it,3} =  nbas;
    iteration{it,4} = bas;
    iteration{it,5} = ObjFunc;
    
    if runn == 'False'
        break;
    end
     if (zN) > 0    % optimal solution
        nonOptimal = 'False';
        iteration{it,6} = 'True';
        ObjFunc = c'*[xB; zN];
        iteration{it,5} = ObjFunc;
        break;
     end     
end