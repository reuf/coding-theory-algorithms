function [ biterrors ] = bsc_benchmark( message, trellis, probability )
%BSC_BENCHMARK Summary of this function goes here
%   Detailed explanation goes here

disp('Encoding...');

code = convenc(message, trellis); 

disp('Simulate BSC transmission scenarios...');

received_codes = zeros(size(code, 1), size(probability, 2)); % every column represents the code for a specific probability
i = 0;
for p = probability
    i = i + 1;
    received_code = burst_channel(code, p, 0, 1, 0); % no bursts
    received_codes(:,i) = received_code';
end

disp('Decoding...');

tblen = tblen_from_trellis(trellis);
biterrors = zeros(size(received_codes, 2), 1);
i = 0;
for received_code = received_codes
    i = i + 1;
    decoded_message = vitdec(received_code, trellis, tblen, 'trunc', 'hard');
    [~, pcterrs] = biterr(message, decoded_message);
    biterrors(i) = pcterrs;
end

end

