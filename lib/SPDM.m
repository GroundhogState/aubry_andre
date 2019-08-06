function [rho_1 ,l1]= SPDM(vec)

%% Single particle DM code - https://github.com/pmrichard/ED-BH-chain
    rho_1 = zeros(length(vec),length(vec));
    %By symmetry of the ground state we just need to compute the first row
    %And then shift to the right, and reflect
    rho_0 = zeros(length(vec),1);
    for i=1:length(vec)
       rho_0_l = anh(vec,1);
       rho_0_r = anh(vec,i);
       rho_0(i) = sum(conj(rho_0_l).*rho_0_r);
    end
    for i=1:length(vec)
        rho_1(i,i:end) =rho_0(1:end-i+1);
    end
    rho_1 = rho_1 + rho_1.';
    for i=1:length(vec)
       rho_1(i,i) = 0.5*rho_1(i,i); 
    end
    l1 = rho_0(floor(length(vec)/2));

end