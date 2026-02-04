function [curr_cond_mean, curr_cond_var, curr_cond_FF] = FanoFactor(R, curr_cond, curr_unit, min_delay, target_onset, time_from_onset, time_window)
    % number of trials
    nTrials = size(R, 2);
    
    % get delay duration values
    total_delays = zeros(nTrials, 1);
    for i=1:nTrials
        total_delays(i) = R(i).delayDur;
    end
    
    % get conditions
    all_trials = 1:nTrials;
    cond_list = zeros(nTrials, 1); %% 1-> barriers, 2-> no barriers
    for i=1:nTrials
        cond_list(i) = R(i).conditionID;
    end
    
    % get condition specific trials
    curr_trial_inds = all_trials(cond_list == curr_cond & total_delays > min_delay);
    curr_cond_counts = zeros(length(curr_trial_inds),1);
    
    for t=1:length(curr_trial_inds)
        curr_trial_data = R(curr_trial_inds(t));
        curr_onset = R(curr_trial_inds(t)).(target_onset);
    
        % get this neuron data
        curr_n_data = curr_trial_data.unit(curr_unit);
        % get spike times
        spike_times = curr_n_data.spikeTimes;
        % align to onset time
        spike_onset_times = spike_times - curr_onset;
        % find number of spikes within given time and time window
        curr_spike_counts = sum(spike_onset_times > time_from_onset - time_window/2 & ...
                                spike_onset_times < time_from_onset + time_window/2);
        curr_cond_counts(t) = curr_spike_counts;
    end
    
    curr_cond_mean = mean(curr_cond_counts);
    curr_cond_var = var(curr_cond_counts);
    curr_cond_FF = curr_cond_var / curr_cond_mean;

end