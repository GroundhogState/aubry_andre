%%  KPNORMDUAL  Computes the dual of the (k,p)-norm of a vector or matrix
%   This function has three required arguments:
%     X: a vector or matrix
%     K: a positive integer
%     P: a real number >= 1, or Inf
%
%   NRM = kpNormDual(X,K,P) is the dual of the (K,P)-norm of the vector or
%   matrix X (see URL for details).
%
%   URL: http://www.qetlab.com/kpNormDual

%   requires: kpNorm.m
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QETLAB
%   last updated: June 24, 2015

function nrm = kpNormDual(X,k,p)

sX = size(X);
nX = min(sX);
xX = max(sX);

% There are some special cases that we can compute slightly faster than
% doing a full SVD, so we consider those cases separately.
if((nX > 1 && k >= nX) && p == 2) % dual of the Frobenius norm is the Frobenius norm
    nrm = norm(X,'fro');
elseif((nX > 1 && k >= nX) && p == 1) % dual of the trace norm is the operator norm, which is computed faster by kpNorm.m, which uses svds in this case
    nrm = kpNorm(X,1,1);
elseif(p == Inf) % this case is needed to avoid errors, not for speed reasons: dual of operator norm is trace norm
    nrm = kpNorm(X,xX,1);
else % in all other cases, it seems like we have to compute all singular values or just brute-force our way with CVX

    % If X is a CVX variable, try to compute the norm in a way that won't
    % piss off MATLAB.
    if(isa(X,'cvx') == 1)
        % Just compute the value via CVX using the definition of what it
        % means to be the dual norm: optimize over the unit ball in the
        % original norm.
        cvx_begin quiet
            cvx_precision best;
            variable Y(sX(2),sX(1)) complex
            maximize real(trace(X'*Y))
            subject to
                kpNorm(Y,k,p) <= 1;
        cvx_end
        
        nrm = real(cvx_optval);
    else
        if(nX == 1)
            k = min(k,xX);
            s = sort(X,'descend');
        else
            k = min(k,nX);
            s = svd(full(X));
        end

        for r=(k-1):-1:0
            av = sum(s(r+1:end))/(k-r);
            if(r == 0);break;end
            if(s(r) > av);break;end
        end
        if(p == 1)
            nrm = max([s(1),av]);
        else
            nrm = norm([s(1:r).',av*ones(1,k-r)],p/(p-1));
        end
    end
end