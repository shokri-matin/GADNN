function [ Chromosome, BestCost, MSE ] = GA( Networks, trainInput, trainOutput, inputNum, outputNum, popSize, bitNum )
%% GA Parameters
    maxIt = 100;
    nPop = popSize;
    crossover_rate = 0.6;
    mutation_rate = 0.4;
    prob = 0.5;
    nCrossover = (crossover_rate * nPop);
    nMutation = (mutation_rate * nPop);

%% Chromosome Structure
    Chromosome.Structure = [];
    Chromosome.W_B = [];
    Chromosome.Cost = [];
    Chromosome.MSE = [];
    Chromosomes = repmat(Chromosome,1,nPop);
    
%% Initialize Population
    for i=1:nPop
       network =  Networks(i);
       Chromosome = Create_Chromosome(network, bitNum);
       Chromosomes(i) = CostFunc(Chromosome, trainInput, trainOutput, inputNum, outputNum, bitNum);
    end    
    %Sort Population
    Chromosomes = SortPopulation( Chromosomes );
    
    %Store Best Solution
    BestSoul = Chromosomes(1);
    
    %Vector to Holds BestCosts
    BestCosts = zeros(maxIt, 1);
    BestMSE = zeros(maxIt, 1);
    
%% GA Main Algorithm
    for it=1:maxIt
        if(rand() < prob)
            %Crossover and Mutiation On Structure
            popc_s = repmat(Chromosome,nCrossover/2,2);
            for k=1:nCrossover/2
                i1 = randi([1 nPop/2]);
                i2 = randi([1 nPop/2]);
                
                parent1 = Chromosomes(i1);
                parent2 = Chromosomes(i2);
                
                [child1, child2] = CrossoverOnStructure(parent1, parent2, inputNum, outputNum, bitNum);
                
                child1 =  CostFunc( child1, trainInput, trainOutput, inputNum, outputNum, bitNum );
                child2 =  CostFunc( child2, trainInput, trainOutput, inputNum, outputNum, bitNum );
                
                popc_s(k,1) = child1;
                popc_s(k,2) = child2;
            end
            popc_s = popc_s(:);
            
            popm_s = repmat(Chromosome,nMutation,1);
            for k=1:nMutation
                i = randi([1 nPop/2]);
                mute_cr = MutationOnStructure(Chromosomes(i),inputNum,outputNum,bitNum);
                popm_s(k)=CostFunc(mute_cr ,trainInput, trainOutput, inputNum, outputNum, bitNum );
            end
            
            %Merge Population
            Chromosomes = [Chromosomes, popc_s', popm_s']; %#ok
            
            %Sort Population 
            Chromosomes = SortPopulation( Chromosomes );
            
            %Delete Extra Population
            Chromosomes = Chromosomes(1:nPop);
            
            %Store Results
            BestSoul = Chromosomes(1);
            BestMSE(it) = BestSoul.MSE;
            BestCosts(it) = BestSoul.Cost;
            disp(['itration' num2str(it) ':  ' 'Best MSE : ' num2str(BestMSE(it)) '  Best Cost : ' num2str(BestCosts(it))]);
        else
            %Crossover and Mutiation On W_B
            popc_W_B = repmat(Chromosome,nCrossover/2,2);
            for k=1:nCrossover/2
                i1 = randi([1 nPop/2]);
                i2 = randi([1 nPop/2]);
                
                parent1 = Chromosomes(i1);
                parent2 = Chromosomes(i2);
                
                [child1, child2] = CrossoverOnW_B(parent1, parent2);
                
                child1 =  CostFunc( child1, trainInput, trainOutput, inputNum, outputNum, bitNum );
                child2 =  CostFunc( child2, trainInput, trainOutput, inputNum, outputNum, bitNum );
                
                popc_W_B(k,1) = child1;
                popc_W_B(k,2) = child2;
            end
            popc_W_B = popc_W_B(:);
            
            popm_W_B = repmat(Chromosome,nMutation,1);
            for k=1:nMutation
                i = randi([1 nPop/2]);
                mute_cr = MutationOnW_B(Chromosomes(i));
                popm_W_B(k)= CostFunc(mute_cr ,trainInput, trainOutput, inputNum, outputNum, bitNum );
            end
            
            %Merge Population
            Chromosomes = [Chromosomes, popc_W_B', popm_W_B']; %#ok
            
            %Sort Population 
            Chromosomes = SortPopulation( Chromosomes );
            
            %Delete Extra Population
            Chromosomes = Chromosomes(1:nPop);
            
            %Store Results
            BestSoul = Chromosomes(1);
            BestMSE(it) = BestSoul.MSE;
            BestCosts(it) = BestSoul.Cost;
            disp(['itration' num2str(it) ':  ' 'Best MSE : ' num2str(BestMSE(it)) '  Best Cost : ' num2str(BestCosts(it))]);
        end
    end
    
%% Display Results
    figure(1);
	plot(1:maxIt,BestCosts,'*');
    figure(2);
	plot(1:maxIt,BestMSE,'*');
    
    Chromosome = BestSoul;
    BestCost = BestSoul.Cost;
    MSE = BestSoul.MSE;
end

