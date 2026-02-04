function [data] = binData(R, timeBins, target_onset)
% binData  bins the data according to a given parameters
%   
% Inputs
%   R : data struct
%
%   timeBins : vector of time bins
%
%   target_onset : string value for field name to align data to
%
% Output
%   data : binned data
    
    % data details
    nTimeBins = length(timeBins)-1;
    nTrials = size(R, 2);
    nUnits = length(R(1).unit);

    % initialize matrix to save data
    data = zeros(nTimeBins, nTrials, nUnits);
    
    % for each trial
    for t=1:nTrials
        % get trial specific data
        curr_trial_data = R(t);
        curr_onset = R(t).(target_onset);
    
        % for each neuron
        for n=1:nUnits
            % get current trial/unit data
            curr_n_data = curr_trial_data.unit(n);
            % get the spike times
            spike_times = curr_n_data.spikeTimes;
            % align to movement onset time
            spike_onset_times = spike_times - curr_onset;
            % bin the spike times accordingly to time bins
            [N, ~] = histcounts(spike_onset_times, timeBins);
            % save to appropriate dimension
            data(:,t,n) = N;
        end
    end
end