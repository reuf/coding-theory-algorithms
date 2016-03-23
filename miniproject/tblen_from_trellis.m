function [ tblen ] = tblen_from_trellis( trellis )
%TBLEN_FROM_TRELLIS Returns truncation depth for code specified by trellis.
%   Returns truncation depth for convolutional code specified by trellis 
%   based on B. Moision's rule of thumb [1].
%
%   [1]  B. Moision. "A Truncation Depth Rule of Thumb for Convolutional 
%        Codes." In Information Theory and Applications Workshop 
%        (January 27 2008-February 1 2008, San Diego, California), 555-557. 
%        New York: IEEE, 2008. 

n = log2(trellis.numOutputSymbols); % n encoder outputs
k = log2(trellis.numInputSymbols);  % k encoder inputs
K = log2(trellis.numStates);        % memory order

r = k / n;                          % code rate

tblen = round(2.5 * K / (1 - r));   % truncation depth rule of thumb [1]

end