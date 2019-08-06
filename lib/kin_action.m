function target = kin_action(vec,i,j)
    % Hops a particle from i to j
    % Assumes vec is in a Fock space of fixed particle number
    target = vec;
    target(i) = target(i) -1;
    target(j) = target(j) +1;
    target = target*(target(i) >0);
end