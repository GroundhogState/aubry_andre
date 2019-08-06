function state = cre(vec,i)
    % Creates a particle at the i-th site, acting on a Fock vector.
    v_temp = vec;
    scalar = sqrt(v_temp(i)+1);
    v_temp(i) = v_temp(i)+1; 
    state = v_temp*scalar;
end