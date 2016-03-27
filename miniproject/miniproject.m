clear; clc; close all hidden;
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

disp('------------------------------------------------------------------');                         
disp(' Benchmark codes on BSC with multiple bit error probabilities     ');
disp('------------------------------------------------------------------'); 

message = randi([0 1], message_len, 1); % generate random message 
p = 0:0.01:0.5;                         % bit error probabilities 
                                 
disp('Benchmark C_conv1 on BSC with multiple bit error probabilities...');                                 
[BER_r, BER_m1] = random_benchmark(message, trellis_1, p);

disp('Benchmark C_conv2 on BSC with multiple bit error probabilities...');                                 
[~, BER_m2] = random_benchmark(message, trellis_2, p);

disp('Benchmark C_conv3 on BSC with multiple bit error probabilities...');                                 
[~, BER_m3] = random_benchmark(message, trellis_3, p);

figure(1);
plot(p*100, BER_m1*100, ...
     p*100, BER_m2*100, ...
     p*100, BER_m3*100, ...
     p*100, BER_r*100, '--');
title('BSC with random errors');
legend('C_{conv1}', 'C_{conv2}', 'C_{conv3}',...
       'channel', 'Location', 'northwest');
xlabel('p [%]');
ylabel('bit error rate [%]');

disp('------------------------------------------------------------------');                        
disp(' Benchmark codes with single burst error of different length on   ');
disp(' otherwise error-free channel                                     ');
disp('------------------------------------------------------------------');                         

message = randi([0 1], message_len, 1); % generate random message
burst_len = 0:500;                      % burst length

disp('Benchmark C_conv1 on channel with single burst error of fixed length...');                                 
[BER_r1, BER_m1] = fixed_burst_benchmark(message, trellis_1, burst_len);

disp('Benchmark C_conv2 on channel with single burst error of fixed length...');                                                                 
[BER_r2, BER_m2] = fixed_burst_benchmark(message, trellis_2, burst_len);

disp('Benchmark C_conv3 on channel with single burst error of fixed length...');                                                                 
[BER_r3, BER_m3] = fixed_burst_benchmark(message, trellis_3, burst_len);

figure(2);
plot(burst_len(1:26), BER_m1(1:26)*100, ...
     burst_len(1:26), BER_m2(1:26)*100, ...
     burst_len(1:26), BER_m3(1:26)*100, ...
     burst_len(1:26), BER_r1(1:26)*100, '--',  ...
     burst_len(1:26), BER_r2(1:26)*100, '-.', ...
     burst_len(1:26), BER_r3(1:26)*100, ':');
title('BSC with single burst error');
legend('C_{conv1}', 'C_{conv2}', 'C_{conv3}',...
       'channel 1', 'channel 2', 'channel 3',...
       'Location', 'northwest');
xlabel('burst length [bit]');
ylabel('bit error rate [%]');

figure(3);
plot(burst_len, BER_m1*100, ...
     burst_len, BER_m2*100, ...
     burst_len, BER_m3*100, ...
     burst_len, BER_r1*100, '--',  ...
     burst_len, BER_r2*100, '-.', ...
     burst_len, BER_r3*100, ':');
title('BSC with single burst error');
legend('C_{conv1}', 'C_{conv2}', 'C_{conv3}',...
       'channel 1', 'channel 2', 'channel 3',...
       'Location', 'northwest');
xlabel('burst length [bit]');
ylabel('bit error rate [%]');

disp('------------------------------------------------------------------');                        
disp(' Benchmark codes on BSC with multiple burst error probabilities   ');
disp('------------------------------------------------------------------');                       

message = randi([0 1], message_len, 1);   % generate random message 
burst_start_p = 0:0.01:1;    % burst start probability (x-axis)
burst_end_p = 0.2:0.2:0.8;   % burst end probability (different figures)

disp('Benchmark C_conv1 on channel with multiple burst error probabilities...');
[BER_r, BER_m1] = burst_benchmark(message, trellis_1, burst_start_p, burst_end_p);

disp('Benchmark C_conv2 on channel with multiple burst error probabilities...');
[~, BER_m2]     = burst_benchmark(message, trellis_2, burst_start_p, burst_end_p);

disp('Benchmark C_conv3 on channel with multiple burst error probabilities...');
[~, BER_m3]     = burst_benchmark(message, trellis_3, burst_start_p, burst_end_p);

figure(4);
for i = 1:size(burst_end_p, 2)                        
    subplot(2,2,i)
    plot(burst_start_p*100, BER_m1(:,i)*100, ...
         burst_start_p*100, BER_m2(:,i)*100, ...
         burst_start_p*100, BER_m3(:,i)*100, ...
         burst_start_p*100, BER_r(:,i)*100, '--');
    str = sprintf('BSC with random burst errors; burst end p = %2.f%%', ...
                   burst_end_p(i)*100);
    title(str);
    if i == 1
        % put legend in first subplot
        legend('C_{conv1}', 'C_{conv2}', 'C_{conv3}',...
               'channel', 'Location','northwest');
    end
    xlabel('burst start p [%]');
    ylabel('bit error rate [%]');
end

disp(['End: ', datestr(now)]);
