function [data, time, input, output] = MackeyGlass(mgdata)
% Normalized MackeyGlass
    time = mgdata(:,1);
    data = mgdata(:,2);
    time = time/max(mgdata(:,1));
    data = data/max(mgdata(:,2));
    timeseries = zeros(1000,5);
    for t = 118:1117,
        timeseries(t-117,:) = [data(t-18) data(t-12) data(t-6) data(t) data(t+6)];
    end
    input = timeseries(:,1:end-1);
    output = timeseries(:,end);
    
    % Add normal white noise
    %x=x+randn(n,1)*level*std(x);
end
