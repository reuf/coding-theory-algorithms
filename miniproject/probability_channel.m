function [ y ] = probability_channel( x, p_rand_err, p_burst_err, p_rand_state, p_burst_state )
%PROBABILITY_CHANNEL Simulate BSC with possibility of burst errors.
%   This function simulates the transmission of the bits x over a BSC. The
%   BSC has two different states, which form a markov chain: random state
%   and burst state. The probabilities of staying in the states are
%   p_rand_state and p_burst_state respectively. The bit error
%   probabilities of each state can be specified with p_rand_err and
%   p_burst_err respectively. Default state is random state. Hence, to 
%   disable the burst state, just set p_rand_state to 1.

burst_state = false;    % true  => burst state
                        % false => random state
                        
y = x;                  % copy input bits; errors are introduced in loop

random_vector = rand(size(x, 1), 4); % pre-generate random numbers (faster)

% iterate over all bits end introduce simulated errors:
for i = 1:size(x)
    if burst_state 
        % simulate bit error with probability p_burst_err:
        if random_vector(i,1) < p_burst_err
            y(i) = 1 - y(i);     % flip bit
        end
        % stay in burst state with probability p_burst_state:
        if random_vector(i,2) >= p_burst_state
            burst_state = false; % leave burst state
        end
    else % random state
        % simulate bit error with probability p_rand_err:
        if random_vector(i,3) < p_rand_err
            y(i) = 1 - y(i);     % flip bit
        end
        % stay in random state with probability p_rand_state:
        if random_vector(i,4) >= p_rand_state
            burst_state = true;  % enter burst state
        end
    end
end

end