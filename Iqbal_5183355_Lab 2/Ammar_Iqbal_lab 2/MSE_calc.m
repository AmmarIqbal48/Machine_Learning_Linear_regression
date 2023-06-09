function [mse_5, mse_95] = MSE_calc(iteration, dataset, MSE_type, regressionAlgo, perc_1, perc_2)

dimension = size(dataset, 1);
mse_5 = 0 ; mse_95 = 0;

% set percentage
ten_pc = floor(dimension * perc_1);
ninety_pc = floor(dimension * perc_2);

% Using "for loop" Compute MSE
for i = 1:iteration
    rand_data = dataset(randperm(dimension), :);
    [w1, w0] = regressionAlgo(rand_data(1:ten_pc,:), 0);      % Compute model on 5% of dataset
    % Compute MSE on
    mse_5 = mse_5 + MSE_type(rand_data(1:ten_pc,:), w1, w0, 0);              % Ten percent of dataset
    mse_95 = mse_95 + MSE_type(rand_data(ten_pc+1:end,:), w1, w0, 0);    % Remaining 95% of dataset
   
end

mse_5 = mse_5 / iteration;
mse_95 = mse_95 / iteration;


% print table
clmn_0 = {'Train set' ; 'Test set' };
clmn_1 = { (ten_pc/dimension)*100 ; (ninety_pc/dimension)*100};
clmn_2 = { mse_5 ; mse_95};
f = figure;
data = [ clmn_0 clmn_1 clmn_2 ];
clmn = {'Dataset' , 'Percentage' , 'MSE'};
uitable(f, 'Data', data, 'ColumnName', clmn, 'Position', [5 340 260 60]);


end