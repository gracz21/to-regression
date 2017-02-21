function [errors_log_training, errors_log_test, errors_zero_ones_training, errors_zero_ones_test] = lambda_experiment()
  #load train data
  [X_train, Y_train] = readdata("data/train.txt", " ");
  
  #load test data
  [X_test, Y_test] = readdata("data/test.txt", " ");
  
  #add additional ones vector to the begining of X matrix
  n = size(X_train, 1);
  X_train_added = [ones(n, 1), X_train];
  n = size(X_test, 1);
  X_test_added = [ones(n, 1), X_test];
  
  errors_log_training = [];
  errors_log_test = [];
  errors_zero_ones_training = [];
  errors_zero_ones_test = [];
  
  #for different lambda values
  for lambda = 1:5:100
    #get W vector
    W = reg_log_NR(X_train, Y_train, lambda);
    
    #predict
    Y_pred_train = X_train_added*W;
    Y_pred_test = X_test_added*W;
    
    #count log error
    errors_log_training = [errors_log_training, mean(log(1 + e.^((-1).*Y_pred_train.*Y_train)))];
    errors_log_test = [errors_log_test, mean(log(1 + e.^((-1).*Y_pred_test.*Y_test)))];
    
    #count 0/1 error
    errors_zero_ones_training = [errors_zero_ones_training, mean(Y_pred_train.*Y_train <= 0)];
    errors_zero_ones_test = [errors_zero_ones_test, mean(Y_pred_test.*Y_test <= 0)];
  end
end