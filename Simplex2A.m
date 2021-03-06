% 2.1 
% maximize      6x1 + 8x2 + 5x3 + 9x4
% subject to    2x1 + x2 + x3 + 3x4 ? 5
%               x1 + 3x2 + x3 + 2x4 ? 3
%               x1, x2, x3, x4 ? 0 .

clc;
clear;
clear workspace;

%% Linear Programming: Problem definition

m=2;n=4;
A=[2 1 1 3; 1 3 1 2];
A=[A eye(m)];
b=[5;3];
c=[6;8;5;9];            % objective function coefficients
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
    
   [xBout, zNout, nbasout, basout, Bout, Nout,ObjFunc, cN] =  funcSimplex3 ( xB, zN,B, N,  nbas, bas,  A, b, c);
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