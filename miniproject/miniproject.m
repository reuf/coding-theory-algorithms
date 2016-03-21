clear; clc;

trellis1 = poly2trellis(7, {'1 + x + x^2 + x^3 + x^6', '1 + x^2 + x^3 + x^5 + x^6'});
trellis2 = poly2trellis(4, {'1 + x^2 + x^3', '1 + x + x^3', '1 + x + x^2 + x^3'});
trellis3 = poly2trellis(3, {'1 + x^2', '1 + x + x^2', '1 + x + x^2', '1 + x + x^2'});

message = randi([0 1],10^6,1);
resolution = 0.01;

[p, biterrors1] = bsc_benchmark(message, trellis1, resolution);
[~, biterrors2] = bsc_benchmark(message, trellis2, resolution);
[~, biterrors3] = bsc_benchmark(message, trellis3, resolution);

biterror_channel = 0:resolution:0.5; % actual BSC bit error

figure % opens new figure window
plot(p, biterrors1, p, biterrors2, p, biterrors3, p, biterror_channel)
legend('C_{conv1}','C_{conv2}','C_{conv3}','channel','Location','northwest')
xlabel('p [%]')
ylabel('bit error rate [%]')


