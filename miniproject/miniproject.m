clear; clc;

trellis1 = poly2trellis(7, {'1 + x + x^2 + x^3 + x^6', '1 + x^2 + x^3 + x^5 + x^6'});
trellis2 = poly2trellis(4, {'1 + x^2 + x^3', '1 + x + x^3', '1 + x + x^2 + x^3'});
trellis3 = poly2trellis(3, {'1 + x^2', '1 + x + x^2', '1 + x + x^2', '1 + x + x^2'});

message = randi([0 1],10^6,1);

p = 0:0.01:0.5;
biterrors1 = bsc_benchmark(message, trellis1, p);
biterrors2 = bsc_benchmark(message, trellis2, p);
biterrors3 = bsc_benchmark(message, trellis3, p);

biterror_channel = p; % theoretical BSC bit error rate

figure % opens new figure window
plot(p, biterrors1, p, biterrors2, p, biterrors3, p, biterror_channel)
legend('C_{conv1}','C_{conv2}','C_{conv3}','channel','Location','northwest')
xlabel('p [%]')
ylabel('bit error rate [%]')


