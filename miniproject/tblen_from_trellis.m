function [ tblen ] = tblen_from_trellis( trellis )
%TBLEN_FROM_TRELLIS Summary of this function goes here
%   Detailed explanation goes here

% http://se.mathworks.com/help/comm/ref/viterbidecoder.html

k = log2(trellis.numInputSymbols);
n = log2(trellis.numOutputSymbols);
r = k / n;
K = log2(trellis.numStates); %memory order (numStates works here..but overall correct?)
tblen = round(2.5 * K / (1 - r)); % should we round up/down?

end

