function [ BER_r, BER_m ] = fixed_burst_benchmark( message, trellis, ...
                                                   burst_lengths )
%FIXED_BURST_BENCHMARK Encoded transmission over channel with single burst  
%                      error of specified length and subsequent decoding.   
%                      Returns the bit error rates of decoded messages   
%                      under all given burst error lengths as well as the  
%                      bit error rates of the original received code
%                      sequences for comparison.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);   % calc Viterbi truncation depth

BER_m = zeros(size(burst_lengths));    % Init vectors which get filled
BER_r = zeros(size(burst_lengths));    % with measured bit error rates for  
                                       % all burst lengths.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');

i = 0;
for l = burst_lengths
    i = i + 1; % count iteration for array indexing
    disp(['  > Scenario: burst length = ', num2str(l)]);

    % Simulate transmission
    received = fixed_burst_channel(code, l); % Burst error with length  
                                             % l on otherwise 
                                             % error-free channel
    % Decode received code                                                     
    decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');

    % Calc bit error rate and save in return array
    [~, pcterrs] = biterr(message, decoded_message); % code
    BER_m(i) = pcterrs;
    [~, pcterrs] = biterr(code, received); % channel
    BER_r(i) = pcterrs;
end

end

