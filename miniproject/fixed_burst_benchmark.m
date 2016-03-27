function [ BER_r, BER_m ] = fixed_burst_benchmark( message, trellis, ...
                                                   burst_lengths, runs )
%FIXED_BURST_BENCHMARK Encoded transmission over channel with single burst  
%                      error of specified length and subsequent decoding.   
%                      To run the benchmark multiple times and take the
%                      mean bit error rate use runs > 1.
%                      Returns the bit error rates of decoded messages   
%                      under all given burst error lengths as well as the  
%                      bit error rates of the original received code
%                      sequences for comparison.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis); % calc Viterbi truncation depth

BER_m = zeros(runs, size(burst_lengths, 2)); % Init matrices which get 
BER_r = zeros(size(BER_m));                  % filled with measured bit   
                                             % error rates for all burst 
                                             % lengths.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');

for run = 1:runs
    disp(['  > Run ', num2str(run), '...']);
    
    i = 0;
    for l = burst_lengths
        i = i + 1; % count iteration for array indexing
        disp(['    > Scenario: burst length = ', num2str(l)]);

        % Simulate transmission
        received = fixed_burst_channel(code, l); % Burst error with length  
                                                 % l on otherwise 
                                                 % error-free channel
        % Decode received code                                                     
        decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');

        % Calc bit error rate and save in return array
        [~, pcterrs] = biterr(message, decoded_message); % code
        BER_m(run, i) = pcterrs;
        [~, pcterrs] = biterr(code, received); % channel
        BER_r(run, i) = pcterrs;
    end
end

% Return mean bit error rate of all runs
BER_m = mean(BER_m); 
BER_r = mean(BER_r);

end

