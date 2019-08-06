function H = hist_entropy(counts, bin_edges)
% Computes the base-10 entropy of a PDF from a histogram (normalized to pdf) by the limiting density of
% discrete points.
% Accepts: bin_edges (possibly nonuniform) and counts of a histogram.
% Improvements: Automatically normalize
        %       Accept raw data?
        %       Use different bases
        %       Accept histogram object?

mask = counts > 0;
counts = counts(mask);
binsizes = diff(bin_edges);
binsizes = binsizes(mask);

H = -sum(counts.*log10(counts.*binsizes));

end
