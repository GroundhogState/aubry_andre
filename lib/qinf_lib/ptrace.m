function rho = ptrace(rho,sys,dim)

% A partial trace function.
% Accepts one density matrix or state vector,  an array of dimensions of the subsystems,
%       and an array of subsystems to trace out.
%
% Outputs the reduced density matrix obtained by tracing out the specified
% subsystems.
% Assumes:
%   Input density matrix is Hermitian. Does this matter??
% Dependencies:
%   None, although a tensor product function (like one from QETLab) is
%   useful in applications.
% References:
%   Similar to Jonas Maziero's Fortran subroutine in https://github.com/jonasmaziero/LibForQ
%       See also https://arxiv.org/abs/1601.07458
%       Published in International Journal of Modern Physics CVol. 28, No. 01, 1750005 (2017)


% Possible optimizations:
%   - Trace out contiguous blocks internally if that buys any time
%   - Convert to a general expression that reduces matrix in a single loop
%   - Sort subsystems by size and trace out the large ones first
%   - Replace MATLAB functions with smarter loops if more efficient
%   - If you have absolute confidence in your inputs, remove the
%       preconditioning steps to reduce total complexity.

%% Preconditioning
% if any(size(rho)) == 1
%     rho = rho'.*rho;                              % Converts ket to density matrix
% end

tr_rho = trace(rho);
if tr_rho ~= 1
    rho = rho/tr_rho;                       %Normalizes density matrix
end

% if ~isequal(rho,rho')
%     error("Density matrix is not Hermitian!") %% SUPER SLOW
% end

if any(sys > length(dim)) || any(sys < 1)
    error("You tried to trace out a system that doesn't exist")
end

%% Function parameters
tr_keep = setdiff(1:length(dim),sys);       %The systems that will be KEPT - input is ones to trace out
dim_out = prod(dim);                        %Will be reduced along the way
left_keep = min(tr_keep);                   % The leftmost system that will remain. Used to condition the first stage.
right_keep = max(tr_keep);                  % The rightmost system that will remain. Used to condition the first stage.
dim_left = prod(dim(1:left_keep-1));        % The dimension that will be traced out on the left
dim_right = prod(dim(right_keep+1:end));    % The dimension that will be traced out on the right

%% Function body
% A small optimization: If there is a large contiguous block on either end,
% trace over the largest first to reduce loop lengths later.
% Relegated to functions for readability & they're only called once.
if dim_left >= dim_right && left_keep > 1
    % Trace left first
       dim_out = dim_out/dim_left;
       rho_left = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_left-1
                    rho_left(i,j) = rho_left(i,j)+rho(i+p*dim_out,j+p*dim_out);
                end
            end
        end
       rho = rho_left;
    if right_keep < length(dim)
        dim_out = dim_out/dim_right;
       rho_right = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_right-1
                        rho_right(i,j)=rho_right(i,j)+rho((i-1)*dim_right+p+1,(j-1)*dim_right+p+1);
                end
            end
        end
        rho = rho_right;
    end
elseif dim_right > dim_left && right_keep < length(dim)
    % Trace right first
    dim_out = dim_out/dim_right;
       rho_right = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_right-1
                        rho_right(i,j)=rho_right(i,j)+rho((i-1)*dim_right+p+1,(j-1)*dim_right+p+1);
                end
            end
        end
        rho = rho_right;
    if left_keep > 1
       dim_out = dim_out/dim_left;
       rho_left = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_left-1
                    rho_left(i,j) = rho_left(i,j)+rho(i+p*dim_out,j+p*dim_out);
                end
            end
        end
       rho = rho_left;
    end
end

% Performs traces over systems that aren't in contiguous blocks reaching to
% the end of the system. Left as loop to reduce function call overheads.
for k=left_keep+1:right_keep-1
    if ismember(k,sys)
        d_mid = dim(k);
        dim_out = dim_out/d_mid;
        d_low = prod(dim(k+1:right_keep));
        rho_mid = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                ii = mod(i-1,d_low) + floor((i-1)/d_low)*d_mid*d_low;
                jj = mod(j-1,d_low) + floor((j-1)/d_low)*d_mid*d_low;
                for p=0:d_mid-1
                       rho_mid(i,j) = rho_mid(i,j)+rho(1+ii+p*d_low,1+jj+p*d_low);
                end
            end
        end
        rho = rho_mid;
    end
end

end

function [rho,dim_out] = left_trace(rho,dim,left_keep,dim_out,dim_left)
       dim_out = dim_out/dim_left;
       rho_left = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_left-1
                    rho_left(i,j) = rho_left(i,j)+rho(i+p*dim_out,j+p*dim_out);
                end
            end
        end
       rho = rho_left;
end

function [rho,dim_out] = right_trace(rho,dim,left_keep,dim_out,dim_right)
       dim_out = dim_out/dim_right;
       rho_right = zeros(dim_out);
        for i=1:dim_out
            for j=1:dim_out
                for p=0:dim_right-1
                        rho_right(i,j)=rho_right(i,j)+rho((i-1)*dim_right+p+1,(j-1)*dim_right+p+1);
                end
            end
        end
        rho = rho_right;
end
