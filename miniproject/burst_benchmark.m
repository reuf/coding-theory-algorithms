function [ BER_r, BER_m ] = burst_benchmark( message, trellis, ...
                                             burst_start_p, burst_end_p )
%BURST_BENCHMARK Encoded transmission over BSC without single random errors 
%                but random burst errors and subsequent decoding. 
%                Returns the bit error rates of decoded messages under all  
%                given channel bit error probabilities as well as the bit 
%                error rates of the original received code sequences for 
%                comparison. The return matrix has the size 
%                length(burst_start_p) x length(burst_end_p).

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);    % calc Viterbi truncation depth
                                            
BER_m = zeros(size(burst_start_p, 2),...% Init matrices which get filled 
              size(burst_end_p,   2));  % with measured bit error rates 
BER_r = zeros(size(BER_m));             % for all probability combinations.
                       
% Encoding ----------------------------------------------------------------                                       
disp('> Encode message...');

code = convenc(message, trellis); 

% Simulated transmission and decoding -------------------------------------
disp('> Simulate transmission and decode...');

i = 0; 
for burst_start_probability = burst_start_p
    i = i + 1; % count iteration for array indexing
    
    j = 0;
    for burst_end_probability = burst_end_p
        j = j + 1; % count iteration for array indexing
        
        disp(['  > Scenario: burst start p = ', num2str(burst_start_probability), ...
                          '; burst end p = ',   num2str(burst_end_probability)]);

        % Simulate transmission
        received = probability_channel(code, ... 
                                       0, ... % no random bit errors 
                                       1, ... % constant burst error
                                       1 - burst_start_probability, ...
                                       1 - burst_end_probability);

        % Decode received code                                                     
        decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');

        % Calc bit error rates and save in return vectors
        [~, BER_m(i, j)] = biterr(message, decoded_message);% decoded msg
        [~, BER_r(i, j)] = biterr(code, received);          % rx codeword
    end
end

end

