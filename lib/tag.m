function tagged_vector = tag(vector)
    % Computes a simple hash of an array of vectors, using the linear
    % independence of the radicals over the integers (or some other math wizardry)
    p = sqrt(100*(1:size(vector,2)) + 3);        
    tagged_vector = vector*p';
end