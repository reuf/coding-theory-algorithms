function [ biterrors ] = bsc_benchmark( message, trellis, probability )
%BSC_BENCHMARK Encoded transmission over BSC with multiple bit error
%              probabilities and subsequent decoding. Returns bit error 
%              rates of transmissions.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);    % calc viterbi truncation depth.

biterrors = zeros(size(probability));   % Init array which gets filled with
                                        % measured bit error rates for all 
                                        % probabilities.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');
i = 0;
for p = probability
    i = i + 1; % count iteration for array indexing
    disp(['  > Scenario: p = ', num2str(p)]);
    
    % Simulate transmission
    received = burst_channel(code, p, 0, 1, 0); % BSC with error 
                                                % probability p; no bursts
    % Decode received code                                                     
    decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');
    
    % Calc bit error rate and save in return array
    [~, pcterrs] = biterr(message, decoded_message); 
    biterrors(i) = pcterrs;
end

end

