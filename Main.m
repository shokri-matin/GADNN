close all;
clear all;
clc;
%% Initial Parameters
load mgdata.dat;
[data, time, input, output] = MackeyGlass(mgdata);
dataNum = size(input,1);
inputNum = size(input,2);
outputNum = size(output,2);
popSize = 500;

%% Test and Train Data
trainPercent = 50;
trainNum = round(dataNum * trainPercent / 100);
testNum = dataNum - trainNum;
r = randperm(dataNum);
trainIndex = r(1:trainNum);
testIndex = r(trainNum+1:end);

trainInput = input(trainIndex,:);
trainOutput = output(trainIndex,:);
testInput = input(testIndex,:);
testOutput= output(testIndex,:);

%% Network Structure
Network.Layer = [];
Network.W = {};
Network.b = [];
Network.ActivationFunction = [];
Network.MSE = [];
Network.RMSE = [];

Networks = repmat(Network,1,popSize);
maxLayerNum = 7;
maxNeron = 16;
bitNum = size(dec2bin(maxNeron),2);
for i=1:popSize    
    Network.Layer = [];
    layerNum = randi(maxLayerNum);
    Network.Layer = [inputNum ,randi(maxNeron,1,layerNum), outputNum];
    Networks(i) = Create_ANN(Network);
end

%% Training
[ Chromosome, BestCost, MSE ] = GA(Networks,trainInput,trainOutput,inputNum,outputNum,popSize,bitNum);
Network = ChromosomeToNetwork(Chromosome, inputNum, outputNum, bitNum);
%% Assesment
Network = Get_NetworkCost( Network, testInput, testOutput);

%% Display 
disp(['MSE Test : ' num2str(Network.MSE)])
figure(3);
%plot(time(1:1000),output,'b');
Net_output = zeros(1,dataNum);
for i=1:dataNum
   x = input(i,:);
   Net_output(i) = DisplayResult(Network,x);
end
hold on;
plot(time(1:1000),Net_output','r');

Net_output = zeros(1,size(testInput,1));
for i=1:size(testInput,1)
   x = testInput(i,:);
   Net_output(i) = DisplayResult(Network,x);
end
hold on;
plot(time(testIndex),Net_output','ob');
title('Mackey-Glass Chaotic Time Series');
xlabel('Time (sec)');

