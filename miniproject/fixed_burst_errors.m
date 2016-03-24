function [y] = fixed_burst_errors(x, length)
%FIXED_BURST_ERRORS simulates a BSC channel with a fixed length error
%(burst)

y = x; %copy of input bits
in_size = size(x,1);
for i = (in_size/2):(in_size/2 + length)
    y(i) = 1 - y(i); %flip bit 
end
