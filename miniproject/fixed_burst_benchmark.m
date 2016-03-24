function [ BER_ch, BER ] = fixed_burst_benchmark( message, trellis, burst_lengths, runs )
%FIXED_BURST_BENCHMARK Encoded transmission over channel with single burst  
%                      error of specified length and subsequent decoding.   
%                      Returns bit error rates of transmissions.

% Initialization ----------------------------------------------------------
tblen = tblen_from_trellis(trellis);    % calc viterbi truncation depth.

BER = zeros(runs, size(burst_lengths, 2)); % Init arrays which gets filled 
BER_ch = zeros(size(BER));                 % with measured bit error rates  
                                           % for all burst lengths.

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
        %disp(['    > Scenario: burst length = ', num2str(l)]);

        % Simulate transmission
        received = fixed_burst_channel(code, l); % Burst error with length l on 
                                                 % otherwise error-free channel
        % Decode received code                                                     
        decoded_message = vitdec(received, trellis, tblen, 'trunc', 'hard');

        % Calc bit error rate and save in return array
        [~, pcterrs] = biterr(message, decoded_message); % code
        BER(run, i) = pcterrs;
        [~, pcterrs] = biterr(code, received); % channel
        BER_ch(run, i) = pcterrs;
    end
end

BER = mean(BER); % Return mean bit error rate of all runs
BER_ch = mean(BER_ch); % Return mean bit error rate of all runs

end

