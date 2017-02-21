function [W] = reg_log_NR(X, Y, l = 10^(-5))
  n = size(X, 1);
  X = [ones(n, 1), X];
  m = size(X, 2);
  W = zeros(m, 1);
  
  [B, grad, H] = count_step_data(X, Y, W, l, n, m);
  
  it = 0;
  
  while(norm(grad) > 10^(-8))
    W = W - H^(-1)*grad;
    [B, grad, H] = count_step_data(X, Y, W, l, n, m);
    it = it + 1;
  end
  
  it
end