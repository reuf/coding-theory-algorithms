function [ p, biterrors ] = bsc_benchmark( message, trellis, resolution )
%BSC_BENCHMARK Summary of this function goes here
%   Detailed explanation goes here

disp('Encoding...');

code = convenc(message, trellis); 


disp('Simulate BSC transmission scenarios...');

received_codes = zeros(0.5/resolution + 1, size(code, 1));
for i = 0:(0.5/resolution)
    p = i * resolution;
    received_code = bsc(code, p);
    received_codes(i+1,:) = received_code';
end


disp('Decoding...');

tblen = tblen_from_trellis(trellis);
biterrors = zeros(0.5/resolution + 1, 1);
for i = 0:(0.5/resolution)
    received_code = received_codes(i+1,:)';
    decoded_message = vitdec(received_code, trellis, tblen, 'trunc', 'hard');
    [~, pcterrs] = biterr(message, decoded_message);
    biterrors(i+1) = pcterrs;
end

p = 0:resolution:0.5;

end

