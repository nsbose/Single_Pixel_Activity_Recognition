N=8; % number of users whose data must be assimilated
%this combines data from all users and sets it in a standar format 
TRAINING_MVE_final={};
for i=1:N:4*N;
    j=ceil(i/N);
% to add a new user to this list copy from here
    load('neladri.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;
%end copy here
load('siddhant.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

load('naved.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

load('rohan.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;


load('pinar.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

load('aaron.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

load('wenyang.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

load('ritika.mat');
TRAINING_MVE_cam1_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam1((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam2_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam2((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam3_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam3((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam4_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam4((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam5_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam5((j-1)*10 +1:10*j,:);
TRAINING_MVE_cam6_final((i-1)*10 +1:10*i,:)=TRAINING_MVE_cam6((j-1)*10 +1:10*j,:);
for k=1:10
TRAINING_MVE_final{i,k}=TRAINING_MVE{j,k};
end
i=i+1;

%end of front
end