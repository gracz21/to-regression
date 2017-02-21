function [error_log_train, error_log_test, error_zero_one_train, error_zero_one_test, W] = learn_NR()
  #load train data
  [X_train, Y_train] = readdata("data/train.txt", " ");
  
  #load test data
  [X_test, Y_test] = readdata("data/test.txt", " ");
  
  #get W vector
  tic
  W = reg_log_NR(X_train, Y_train);
  toc
  csvwrite('results/W_NR.txt', W);
  
  #add additional ones vector to the begining of X matrix
  n = size(X_train, 1);
  X_train = [ones(n, 1), X_train];
  n = size(X_test, 1);
  X_test = [ones(n, 1), X_test];
  
  #predict
  Y_pred_train = X_train*W;
  Y_pred_test = X_test*W;
  
  #count log error
  error_log_train = mean(log(1 + e.^((-1).*Y_pred_train.*Y_train)));
  error_log_test = mean(log(1 + e.^((-1).*Y_pred_test.*Y_test)));
  error_log_train
  error_log_test
  
  #count 0/1 error
  error_zero_one_train = mean(Y_pred_train.*Y_train <= 0);
  error_zero_one_test = mean(Y_pred_test.*Y_test <= 0);
  error_zero_one_train
  error_zero_one_test
  
  #plot histogram
  f = figure();
  hist(W);
  title('Histogram wag dla metody N-R');
  saveas(f, 'results/histNR.png');
end