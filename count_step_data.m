function [B, grad, H] = count_step_data(X, Y, W, l, n)
  B = diag(1./(1+e.^(Y.*(X*W))));
  H = X'*B*(eye(n)-B)*X;
  if(det(H) == 0)
    H = l*eye(m) + X'*B*(eye(n)-B)*X;
    grad = l*W - X'*B*Y;
  else
    grad = (-1)*X'*B*Y;
  end
end