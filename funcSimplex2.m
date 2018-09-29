function [xBout, zNout, nbasout, basout, Bout, Nout, cN] = simplex (  xB, zN, nbas, bas, B, N, A, b, c)

if all(xB > 0)
    % the initial solution is primal feasible, and hence we can apply the
    % simplex method without needing any Phase I procedure
    
    %Step1
    if any(zN < 0)
        %negative components, the current solution is not optimal.
        
        %Step2 - j- index, M- min value. The most negative of the two nonbasic dual
        % variables, we see that the entering index is j
        [M,j] = min(zN);
        j_ind = nbas(j);
        
        %Step3
        Ej = zeros(length(nbas),1);
        Ej(sub2ind(size(Ej),j,1:numel(j))) = 1; % insert 1 on j-th position
        deltaxB = inv(B)*N* Ej;
        
        %Step4 - calculate the ratio that achieved the maximum
        for el =1 : length(deltaxB)
            Ratio(el) = deltaxB(el)/xB(el);
        end
        [t, i] = max(Ratio);
        t = (max(Ratio))^(-1);
        
        %Step5 - calculate the ind-th basis index
        i_ind = bas(i);
        
        %Step6
        Ei = zeros(length(bas),1);
        Ei(sub2ind(size(Ei),i,1:numel(i))) = 1;
        deltazN = -(inv(B)*N)'*Ei;
        
        %Step7
        s = zN(j)/deltazN(j);
        
        %Step8
        xB = xB - t * deltaxB;
        zN = zN - s * deltazN;
        
        %Step9 - new sets of basic and nonbasic indices are
        %B = {1, 4, 5} and N = {3, 2}.
        
        nbas(nbas==j_ind)=i_ind;
        bas(bas==i_ind)=j_ind;
        B = A(:,bas);
        N = A(:, nbas);
        
        cB = c(bas,:);
        cN = c(nbas,:);
        
        % xb = B^(-1)*b -  initial basic variables
        xB = inv(B)*b;
        
        % zn = (B^(-1)*N)'*cB-cN - initial nonbasic dual variableS
        zN = (inv(B)*N).'*cB-cN;
    
    end

end


xBout = xB;
zNout = zN;
nbasout = nbas;
basout = bas;
Bout = B;
Nout = N;





