function state = rand_qubit()
%Produces a qubit density matrix when given a polarization vector
    P = 2*rand(3,1)-1;
    if norm(P)~=0
        P = P/norm(P);
    end
    state = 0.5*(eye(2) + P(1)*Pauli('X',0) + P(2)*Pauli('Y',0)+P(3)*Pauli('Z',0));
end