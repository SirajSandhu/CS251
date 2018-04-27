function [x, X, y] = prepData(filename)
	data = csvread(filename);
	x = data(:, 1);
	X = [ones(length(x), 1), x];
	y = data(:, 2);
end

function plotData(x, X, y, w, name)
	plot(x, y, 'rx');
	hold on;
	plot(x, X * w, '-');
	title(name);
	filename = [name ".pdf"]
	print -dpdf filename
end

function err = rmse(y, pred)
	del = y - pred;
	del = diff .^ 2;
	err = sqrt(sum(del) / length(y));
end

%% ============= step 1 ============================
[x_train, X_train, y_train] = prepData('train.csv');


%% ============= step 2 ============================
w = normrnd(0, 1, [2, 1]);


%% ============= step 3 ============================
plotData(x_train, X_train, y_train, w, "initial");


%% ============= step 4 ============================
w_direct = (pinv(X_train' * X_train)) * X_train' * y_train;
plotData(x_train, X_train, y_train, x_direct, "using_direct_soln");


%% ============= step 5 ============================
N = 150000;
eta = 0.0000001;

for nepoch = 1:N
	actv = X_train * w - y_train;
	del = X_train' * actv;
	w = w - (eta / length(y_train)) * del;
end


%% ============= step 6 ============================
plotData(x_train, X_train, y_train, w, "after_gradient_descent");


%% ============= step 7 ============================
[x_test, X_test, y_test] = prepData('test.csv');

y_pred1 = X_test * w;
printf('RMSE using gradient descent:\n');
err1 = rmse(y_test, y_pred1)

y_pred2 = X_test * w_direct;
printf('RMSE using normal equation:\n');
err2 = rmse(y_test, y_pred2)
