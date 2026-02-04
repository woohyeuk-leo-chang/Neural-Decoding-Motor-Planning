function plotRaster(R, nTrials, trials, neuron_type)
% plotRaster  plots a raster
%   
% Inputs
%   R : struct with all the information
%
%   nTrials : number of trials to plot in raster
%   
%   trials : vector of specific trial numbers
%
%   neuron_type : scalar value indicating which neuron to plot
%
% Output
%   raster plot

    hold on

    for i=1:nTrials
        % get current trial's spike data
        curr_trial_ind = trials(i);
        curr_spikes = R(curr_trial_ind).unit;
        curr_targetTime = R(curr_trial_ind).targetAppearsTime;
        curr_goCueTime = R(curr_trial_ind).goCueTime;
        curr_which = R(curr_trial_ind).whichArray;
    
        curr_spikes = curr_spikes(curr_which == neuron_type);
        
        % for each unit
        for j=1:length(curr_spikes)
            % get spike times
            curr_spike_times = curr_spikes(j).spikeTimes';
            curr_spike_times = curr_spike_times(curr_spike_times < curr_goCueTime & ...
                                                curr_spike_times > curr_targetTime);
    
            if isempty(curr_spike_times)
                continue
            else
                spike_time_x = repmat(curr_spike_times,2,1);
                spike_time_y = zeros(size(spike_time_x));
                spike_time_y(1,:) = length(curr_spikes)*(i-1)+j-1;
                spike_time_y(2,:) = length(curr_spikes)*(i-1)+j+1;
                plot(spike_time_x, spike_time_y, 'Color', "k", "LineWidth", 3);
            end
        end
    end
    
    ylim tight
    xlabel("Time (ms)", FontSize=13)
    ylabel("Trials x Units", FontSize=13)
    hold off
end