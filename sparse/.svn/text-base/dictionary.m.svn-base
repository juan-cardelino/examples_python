


%load('ecg_data_for_dictionary');
load('base_sparse_todos');
%load('base_sparse_100');
B=C;
N=1000;
%B=B(:,1:N);
[n,m]=size(B);
desc='todos';

%fprintf('nb of training vectors: %d used %d\n',m,N);
fprintf('nb of training vectors: %d\n',m);

% %fixed number of coefficients
% param.L = 3;   % number of elements in each linear combination.
% param.K = 300; % number of dictionary elements
% param.numIteration = 50; % number of iteration to execute the K-SVD algorithm.
% param.errorFlag = 0; % decompose signals until a certain error is reached. do not use fix number of coefficients.
% param.preserveDCAtom = 0;

% fixed error goal
param.errorGoal = 0.005;
param.K = 300;
param.errorFlag=1;
param.preserveDCAtom = 0;
param.numIteration = 50;
 


%%%%%%%% initial dictionary: Dictionary elements %%%%%%%%
use_initial=0;
if ~use_initial
	param.InitializationMethod =  'DataElements';
else
	load(['trained_dictionary_' num2str(m) '_' num2str(param.K) '_' desc],'D');
	param.InitializationMethod =  'GivenMatrix';
	param.initialDictionary = D;
end

param.displayProgress = 1;
disp('Starting to  train the dictionary');

[D,output]  = KSVD(B,param);


save(['trained_dictionary_' num2str(m) '_' num2str(param.K) '_' desc],'D');
