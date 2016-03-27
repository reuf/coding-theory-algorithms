function [ BER_r, BER_m ] = random_benchmark( message, trellis, ...
                                              probabilities )
%RANDOM_BENCHMARK Encoded transmission over BSC with multiple bit error
%                 probabilities (given as vector) and subsequent Viterbi
%                 decoding.
%                 Returns the bit error rates of decoded messages under all  
%                 given channel bit error probabilities as well as the bit 
%                 error rates of the original received code sequences for 
%                 comparison.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);   % calc Viterbi truncation depth.

BER_m = zeros(size(probabilities));    % Init vectors which get filled with
BER_r = zeros(size(probabilities));    % measured bit error rates for all 
                                       % probabilities.

% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');

i = 0;
for p = probabilities
    i = i + 1; % count iteration for array indexing
    disp(['  > Scenario: p = ', num2str(p)]);
    
    % Simulate transmission
    received = probability_channel(code, p, 0, 1, 0); % BSC with error 
                                                      % probability p; 
                                                      % no burst errors
    % Decode received code                                                     
    decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');
    
    % Calc bit error rates and save in return vectors
    [~, pcterrs] = biterr(message, decoded_message);  % decoded message
    BER_m(i) = pcterrs;
    [~, pcterrs] = biterr(code, received);            % received codeword
    BER_r(i) = pcterrs;
end

end

