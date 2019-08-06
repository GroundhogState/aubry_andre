function state = qubit(P)
%Produces a qubit density matrix when given a polarization vector
    if norm(P)~=0
        P = P/norm(P);
    end
    state = 0.5*(eye(2) + P(1)*Pauli('X',0) + P(2)*Pauli('Y',0)+P(3)*Pauli('Z',0));
end