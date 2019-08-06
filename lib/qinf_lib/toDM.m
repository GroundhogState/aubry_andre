function rho = toDM(ket)
    if ket == zeros(size(ket))
        rho =  zeros(length(ket));
    else
        ket = ket/norm(ket);
        rho = ket'.*ket;
    end
end