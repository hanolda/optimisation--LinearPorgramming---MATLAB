% Chapter 3 Section 1 (p.25) 
% ? = 5 + x3 ? x1
% x2 = 5 + 2x3 ? 3x1
% x4 = 7 ? 4x1
% x5 = x1,

clc;
clear;
clear workspace;

%% Linear Programming: Problem definition

m=3;n=3;
A=[1 0 -2; 4 0 0;-1 0 0];
A=[A eye(m)];
b=[5;7];
c=[-1; 0; 1];            % objective function coefficients
c=[c;zeros(m,1)];

bas=n+1:m+n;
nbas=1:n;

cB = c(bas,:);
cN = c(nbas,:);

B = A(:,bas);
N = A(:, nbas);

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
y=[]
while nonOptimal
    
   [xBout, zNout, nbasout, basout, Bout, Nout,ObjFunc, cN] = funcSimplex3 ( xB, zN,B, N,  nbas, bas,  A, b, c)
    it =it+ 1;
    
    xB = xBout
    zN = zNout
    nbas = nbasout;
    bas = basout;
    B = Bout;
    N = Nout;
    
    y= [y ObjFunc]
    %sulution representation
    iteration{it,1} = xB;
    iteration{it,2} = zN;
    iteration{it,3} =  nbas;
    iteration{it,4} = bas;
    iteration{it,5} = ObjFunc;
    

    
    
     if (zN) > 0    % optimal solution
        nonOptimal = 'False';
        iteration{it,6} = 'True';
        ObjFunc = c'*[xB; zN];
        iteration{it,5} = ObjFunc;
        break;
     end     
end