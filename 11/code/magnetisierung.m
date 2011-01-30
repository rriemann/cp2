clear all;
B = [-0.5:1/100:0.5];
beta = [0:3/100:3];
L = 1;

dim = size(beta)(2);

M = zeros(dim);

for i = 1:dim
  for j = 1:dim
    M(i,j) = L*(exp(2*beta(j))*cosh(beta(j)*B(i))*sinh(beta(j)*B(i))/sqrt(exp(2*beta(j))*(cosh(beta(j)*B(i)))^2 - 2*sinh(2*beta(j))) + exp(beta(j))*sinh(beta(j)*B(i))) / ( sqrt(exp(2*beta(j))*(cosh(beta(j)*B(i)))^2-2*sinh(2*beta(j))) + exp(beta(j))*cosh(beta(j)*B(i)) );
  end
end

surf(beta,B,M);
xlabel('β');
ylabel('B');
zlabel('M');

print("../tmp/magnetisierung.pdf");