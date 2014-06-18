clear all 
close all
home

ecg=1;
if(ecg)
	load ecg_data_for_dictionary
	load base_kl.mat

	w=B(:,1);
	n=length(w);

	s=w'*base_struct.base;

	figure
	plot(w,'-b');
	hold on
	title('signal')

	k=8;
	w_r=base_struct.base(:,1:k)*s(1:k)';
	plot(w_r,'-r');
	hold off
	legend('original','sparse');
	title('K-L transform (signals)')
	figure
	bar(s);
	title('K-L transform (coefs)')
	v_0=0;
	e=norm(w_r-w)/norm(w);
	fprintf('K-L error: %g\n',e);
else
	n=100;
	v=rand(n,1)>0.9;
	v_0=sum(v);
	ruido=0.01;
	w=v+ruido*randn(n,1);
end

%bases
if(ecg)
	KL=base_struct.base;
end

trained=1;
if(trained)
	%load('trained_dictionary_1000_200','D');
	%load('trained_dictionary_1869_220_100','D');
	%load('trained_dictionary_3150_220_todos','D');
	load('trained_dictionary_3150_300_todos','D');
	%load('trained_dictionary_1869_300_100','D');
end

%fixed bases
I=eye(n);
F=fft(I);
DCT=dct(I);
R=randn(n);

%A=[I;DCT];
A=[D'];

m=size(A,1);

%sol = SolveBP(A', w,m);
tol=0.01;
%sol = SolveBP(A', w,m,30,0,tol);
sol = OMPerr(A', w,tol);

x_0=sum(abs(sol)>tol);
x_0=full(x_0);	%this is necessary when output comes from OMPerr from ksvd toolbox
fprintf('original ||w||=%d (only works for binary sequences)\n',v_0);
fprintf('sparse solution ||x||=%d\n',x_0);

figure
plot(w,'-r')
hold on 
x=sol.*(abs(sol)>tol);
b_r=A'*x;
plot(b_r,'-b')
legend('original','sparse');
title('sparse representation')
hold off
e_abs=norm(b_r-w);
e_rel=e_abs/norm(w);
fprintf('sparese error abs: %g error rel: %g\n',e_abs,e_rel);

