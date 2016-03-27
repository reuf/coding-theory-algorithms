function [ BER_ch, BER ] = burst_benchmark( message, trellis, burst_start_probabilities, burst_end_probability )
%BURST_BENCHMARK Encoded transmission over BSC without single random errors 
%                        but random burst errors and subsequent decoding. 
%                        Returns bit error rates of transmissions.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);    % calc viterbi truncation depth.

BER = zeros(size(burst_start_probabilities));    % Init arrays which gets 
BER_ch = zeros(size(burst_start_probabilities)); % filled with measured bit  
                                                 % error rates for all 
                                                 % probabilities.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');
i = 0;
for burst_start_probability = burst_start_probabilities
    i = i + 1; % count iteration for array indexing
    %disp(['  > Scenario: burst start p = ', num2str(burst_start_probability)]);
    
    % Simulate transmission
    received = probability_channel(code, ... 
                                   0, ... % no random bit errors 
                                   1, ... % constant burst error
                                   1 - burst_start_probability, ...
                                   1 - burst_end_probability);
    
    % Decode received code                                                     
    decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');
    
    % Calc bit error rate and save in return array
    [~, pcterrs] = biterr(message, decoded_message); % code
    BER(i) = pcterrs;
    [~, pcterrs] = biterr(code, received); % channel
    BER_ch(i) = pcterrs;
end

end

