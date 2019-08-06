function state = anh(vec,i)
    % Annihilates a particle at site i in the Fock basis
    v_temp = vec;
    scalar = sqrt(v_temp(i));
    v_temp(i) = v_temp(i)-1; 
    state = v_temp*scalar;
end
