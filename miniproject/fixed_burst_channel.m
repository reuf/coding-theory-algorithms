function [y] = fixed_burst_channel(x, burst_length)
%FIXED_BURST_CHANNEL Flip burst_length bits in the middle of the
%                    transmitted sequence x.

y = x; % copy input bits; errors are introduced in loop

% Flip burst_length bits in the middle of the code
burst_middle = size(x, 1) / 2;
burst_start = round(burst_middle - burst_length / 2);
burst_end = burst_start + burst_length;
for i = burst_start:burst_end
    y(i) = 1 - y(i); %flip bit 
end

end