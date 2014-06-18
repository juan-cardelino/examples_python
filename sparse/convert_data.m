load('recs');
normalize=1;



% proceso los latidos
N=0;
for i=1:recnum,
    rec=deblank(recs(i,:));
	  fprintf(['Registro No: ' rec '\n']);
	 load(rec,'QRSs');
	 N=N+length(QRSs);
end


fprintf('total %d\n',N);
B=zeros(73,N);
v=zeros(73,1);

pos=1;
for i=1:recnum,
    rec=deblank(recs(i,:));
	  fprintf(['Registro No: ' rec '\n']);
	 load(rec,'QRSs');
	 for j=1:length(QRSs)
		 v=QRSs(j).signal1;
		if(normalize)
			v=v-mean(v);
			pot=sqrt(v'*v);
			v=v/pot;
		end
		 B(:,pos)=v;
		 pos=pos+1;
	 end
end


save('ecg_data_for_dictionary','B');
