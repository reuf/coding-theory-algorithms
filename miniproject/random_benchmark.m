function [ BER_ch, BER ] = random_benchmark( message, trellis, probabilities )
%RANDOM_BENCHMARK Encoded transmission over BSC with multiple bit error
%                 probabilities and subsequent decoding. Returns bit error 
%                 rates of transmissions.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);    % calc viterbi truncation depth.

BER = zeros(size(probabilities));       % Init arrays which gets filled with
BER_ch = zeros(size(probabilities));    % measured bit error rates for all 
                                        % probabilities.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');
i = 0;
for p = probabilities
    i = i + 1; % count iteration for array indexing
    %disp(['  > Scenario: p = ', num2str(p)]);
    
    % Simulate transmission
    received = burst_channel(code, p, 0, 1, 0); % BSC with error 
                                                % probability p; no bursts
    % Decode received code                                                     
    decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');
    
    % Calc bit error rate and save in return array
    [~, pcterrs] = biterr(message, decoded_message); % code
    BER(i) = pcterrs;
    [~, pcterrs] = biterr(code, received); % channel
    BER_ch(i) = pcterrs;
end

end

