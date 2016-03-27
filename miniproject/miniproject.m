clear; clc; 
disp(['Start: ', datestr(now)]);

message_len = 10^6;

% -------------------------------------------------------------------------                         
% Init trellis structures describing our 3 convolutional codes 
% -------------------------------------------------------------------------                         

trellis_1 = poly2trellis(7, {'1 + x + x^2 + x^3 + x^6', ...
                             '1 + x^2 + x^3 + x^5 + x^6'});
                        
trellis_2 = poly2trellis(4, {'1 + x^2 + x^3', ...
                             '1 + x + x^3', ...
                             '1 + x + x^2 + x^3'});
                        
trellis_3 = poly2trellis(3, {'1 + x^2', ...
                             '1 + x + x^2', ...
                             '1 + x + x^2', ...
                             '1 + x + x^2'});

% -------------------------------------------------------------------------                         
% Benchmark codes on BSC with multiple bit error probabilities
% -------------------------------------------------------------------------

message = randi([0 1], message_len, 1); % generate random message 
p = 0:0.01:0.5;                         % bit error probabilities to 
                                 
disp('Benchmark C_conv1 on BSC with multiple bit error probabilities:');                                 
[BER_ch1, BER_1] = random_benchmark(message, trellis_1, p);

disp('Benchmark C_conv2 on BSC with multiple bit error probabilities:');                                 
[BER_ch2, BER_2] = random_benchmark(message, trellis_2, p);

disp('Benchmark C_conv3 on BSC with multiple bit error probabilities:');                                 
[BER_ch3, BER_3] = random_benchmark(message, trellis_3, p);

figure;
plot(p, BER_1, p, BER_2, p, BER_3, p, BER_ch1, p, BER_ch2, p, BER_ch3);
title('BSC with random errors');
legend('C_{conv1}','C_{conv2}','C_{conv3}',...
       'channel 1','channel 2','channel 3',...
       'Location','northwest');
xlabel('p [%]');
ylabel('bit error rate [%]');

% -------------------------------------------------------------------------                         
% Benchmark codes with single burst error of different length on otherwise
% error-free channel
% -------------------------------------------------------------------------                         

message = randi([0 1], message_len, 1); % generate random message with 10^6 bits
burst_len = 0:50;                       % bit error probabilities to simulate
runs = 50;  

disp('Benchmark C_conv1 on channel with single burst error of fixed length:');                                 
[BER_ch1, BER_1] = fixed_burst_benchmark(message, trellis_1, burst_len, runs);

disp('Benchmark C_conv2 on channel with single burst error of fixed length:');                                                                 
[BER_ch2, BER_2] = fixed_burst_benchmark(message, trellis_2, burst_len, runs);

disp('Benchmark C_conv3 on channel with single burst error of fixed length:');                                                                 
[BER_ch3, BER_3] = fixed_burst_benchmark(message, trellis_3, burst_len, runs);

figure;
plot(burst_len, BER_1, burst_len, BER_2, burst_len, BER_3, ...
     burst_len, BER_ch1, burst_len, BER_ch2, burst_len, BER_ch3);
title('BSC with single burst error');
legend('C_{conv1}','C_{conv2}','C_{conv3}',...
       'channel 1','channel 2','channel 3',...
       'Location','northwest');
xlabel('burst length [bit]');
ylabel('bit error rate [%]');

% -------------------------------------------------------------------------                         
% Benchmark codes with single burst error of different length on otherwise
% error-free channel
% -------------------------------------------------------------------------                         

message = randi([0 1], message_len, 1); % generate random message with 10^6 bits
burst_len = 0:1000;                       % bit error probabilities to simulate
runs = 10;  

disp('Benchmark C_conv1 on channel with single burst error of fixed length:');                                 
[BER_ch1, BER_1] = fixed_burst_benchmark(message, trellis_1, burst_len, runs);

disp('Benchmark C_conv2 on channel with single burst error of fixed length:');                                                                 
[BER_ch2, BER_2] = fixed_burst_benchmark(message, trellis_2, burst_len, runs);

disp('Benchmark C_conv3 on channel with single burst error of fixed length:');                                                                 
[BER_ch3, BER_3] = fixed_burst_benchmark(message, trellis_3, burst_len, runs);

figure;
plot(burst_len, BER_1, burst_len, BER_2, burst_len, BER_3, ...
     burst_len, BER_ch1, burst_len, BER_ch2, burst_len, BER_ch3);
title('BSC with single burst error');
legend('C_{conv1}','C_{conv2}','C_{conv3}',...
       'channel 1','channel 2','channel 3',...
       'Location','northwest');
xlabel('burst length [bit]');
ylabel('bit error rate [%]');


% -------------------------------------------------------------------------                         
% Benchmark codes with single burst error of different length on otherwise
% error-free channel
% -------------------------------------------------------------------------                         

message = randi([0 1], message_len, 1); % generate random message 
burst_start_probabilities = 0:0.01:1; 
burst_end_probabilities = 0.1:0.1:0.9;

[BER_ch1, BER_1] = burst_benchmark(message, trellis_1, burst_start_probabilities, burst_end_probabilities);
[BER_ch2, BER_2] = burst_benchmark(message, trellis_2, burst_start_probabilities, burst_end_probabilities);
[BER_ch3, BER_3] = burst_benchmark(message, trellis_3, burst_start_probabilities, burst_end_probabilities);


figure;
i = 0;
for burst_end_probability = burst_end_probabilities
    i = i+1;
                                 
    subplot(3,3,i)
    plot(burst_start_probabilities, BER_1(:,i), ...
         burst_start_probabilities, BER_2(:,i), ...
         burst_start_probabilities, BER_3(:,i),...
         burst_start_probabilities, BER_ch1(:,i), ...
         burst_start_probabilities, BER_ch2(:,i), ...
         burst_start_probabilities, BER_ch3(:,i));
    str = sprintf('BSC with random burst errors; burst end probability = %.1f', burst_end_probability);
    title(str);
    if i == 1
        legend('C_{conv1}','C_{conv2}','C_{conv3}',...
               'channel 1','channel 2','channel 3',...
                'Location','northwest');
    end
    xlabel('burst start probability [%]');
    ylabel('bit error rate [%]');
end

disp(['End: ', datestr(now)]);
