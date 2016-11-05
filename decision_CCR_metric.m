%EC720
%Code developed by Siddhant Sharma & Neladri Bose
%load training data for MVE and deriv
%this returns TRAINING_MVE, TRAINING_MVE_cam1 ..... TRAINING_MVE_cam6
% save these 7 files with the name of the user;
%this gives CCR for the user, you can check the number of correlated
%samples
clc;clear all;
act_no=3; % upto 4 activities 
sample_no=10; %10 samples per activity
L=40;  %samples after interpolation 
%% Load all files saved from activity_tracker
load('sid_front.mat');
load('sid_sit.mat');
load('sid_stand.mat');
%load('sid_write.mat');
%%
for j=1:10
    user{1,j}=cell2mat(front(1,j));
    user{2,j}=cell2mat(sit(1,j));
    user{3,j}=cell2mat(stand(1,j));
   % user{4,j}=cell2mat(write(1,j));
end
TRAINING_MVE_cam1=zeros(act_no*sample_no,L);
TRAINING_MVE_cam2=zeros(act_no*sample_no,L);
TRAINING_MVE_cam3=zeros(act_no*sample_no,L);
TRAINING_MVE_cam4=zeros(act_no*sample_no,L);
TRAINING_MVE_cam5=zeros(act_no*sample_no,L);
TRAINING_MVE_cam6=zeros(act_no*sample_no,L);
%% INITIALIZATION OF TRAINING DATA PER CAM and generating TRAINING_MVE
TRAINING=(user); %TRAINING_deriv=siddhant;

TRAINING_MVE={};
for i=1:act_no
    for j=1:sample_no
        TRAINING_MVE{i,j}=zeros(6,L);
    end
end

count=1;
for i=1:act_no
    for j=1:sample_no
        
    TRAINING_MVE_cam1(count,1:L)=interp1(1:size(TRAINING{i,j}(1,:),2),TRAINING{i,j}(1,:), linspace(1,size(TRAINING{i,j}(1,:),2),L),'pchip');
    TRAINING_MVE_cam1(count,1:L)=(TRAINING_MVE_cam1(count,:) - mean(TRAINING_MVE_cam1(count,:))) ./ var(TRAINING_MVE_cam1(count,:));
    TRAINING_MVE{i,j}(1,:)= TRAINING_MVE_cam1(count,1:L);
    
    TRAINING_MVE_cam2(count,1:L)=interp1(1:size(TRAINING{i,j}(2,:),2),TRAINING{i,j}(2,:), linspace(1,size(TRAINING{i,j}(2,:),2),L),'pchip');
    TRAINING_MVE_cam2(count,1:L)=(TRAINING_MVE_cam2(count,:) - mean(TRAINING_MVE_cam2(count,:))) ./ var(TRAINING_MVE_cam2(count,:));
    TRAINING_MVE{i,j}(2,:)= TRAINING_MVE_cam2(count,1:L);
    
    TRAINING_MVE_cam3(count,1:40)=interp1(1:size(TRAINING{i,j}(3,:),2),TRAINING{i,j}(3,:), linspace(1,size(TRAINING{i,j}(3,:),2),L),'pchip');
    TRAINING_MVE_cam3(count,1:40)=(TRAINING_MVE_cam3(count,:) - mean(TRAINING_MVE_cam3(count,:))) ./ var(TRAINING_MVE_cam3(count,:));
    TRAINING_MVE{i,j}(3,:)= TRAINING_MVE_cam3(count,1:L);
    
    TRAINING_MVE_cam4(count,1:40)=interp1(1:size(TRAINING{i,j}(4,:),2),TRAINING{i,j}(4,:), linspace(1,size(TRAINING{i,j}(4,:),2),L),'pchip');
    TRAINING_MVE_cam4(count,1:40)=(TRAINING_MVE_cam4(count,:) - mean(TRAINING_MVE_cam4(count,:))) ./ var(TRAINING_MVE_cam4(count,:));
    TRAINING_MVE{i,j}(4,:)= TRAINING_MVE_cam4(count,1:L);
    
    TRAINING_MVE_cam5(count,1:40)=interp1(1:size(TRAINING{i,j}(5,:),2),TRAINING{i,j}(5,:), linspace(1,size(TRAINING{i,j}(5,:),2),L),'pchip');
    TRAINING_MVE_cam5(count,1:40)=(TRAINING_MVE_cam5(count,:) - mean(TRAINING_MVE_cam5(count,:))) ./ var(TRAINING_MVE_cam5(count,:));
    TRAINING_MVE{i,j}(5,:)= TRAINING_MVE_cam5(count,1:L);
    
    TRAINING_MVE_cam6(count,1:40)=interp1(1:size(TRAINING{i,j}(6,:),2),TRAINING{i,j}(6,:), linspace(1,size(TRAINING{i,j}(6,:),2),L),'pchip');
    TRAINING_MVE_cam6(count,1:40)=(TRAINING_MVE_cam6(count,:) - mean(TRAINING_MVE_cam6(count,:))) ./ var(TRAINING_MVE_cam6(count,:));
    TRAINING_MVE{i,j}(6,:)= TRAINING_MVE_cam6(count,1:L);
    
    count=count+1;
    end
end
%%
count=1;
group=ones(sample_no,1);
for i=2:act_no
    temp = [i*ones(sample_no,1)]; 
    group= [group;temp];
end
decision=[zeros(act_no,sample_no)];
class=zeros(6,1); %(cams,1)
for i=1:act_no
    for j=1:sample_no
     sample_MVE=TRAINING_MVE{i,j};
     [Y1,~] = removerows(TRAINING_MVE_cam1,'ind',count);
     [Y2,~] = removerows(TRAINING_MVE_cam2,'ind',count);
     [Y3,~] = removerows(TRAINING_MVE_cam3,'ind',count);
     [Y4,~] = removerows(TRAINING_MVE_cam4,'ind',count);
     [Y5,~] = removerows(TRAINING_MVE_cam5,'ind',count);
     [Y6,~] = removerows(TRAINING_MVE_cam6,'ind',count);
     [g,~] = removerows(group,'ind',count);
     class(1)=knnclassify(sample_MVE(1,:),Y1,g,1,'cityblock');%k=1;
     class(2)=knnclassify(sample_MVE(2,:),Y2,g,1,'cityblock');
     class(3)=knnclassify(sample_MVE(3,:),Y3,g,1,'cityblock');
     class(4)=knnclassify(sample_MVE(4,:),Y4,g,1,'cityblock');
     class(5)=knnclassify(sample_MVE(5,:),Y5,g,1,'cityblock');
     class(6)=knnclassify(sample_MVE(6,:),Y6,g,1,'cityblock');
     big_class{i,j}=class;
     %decision 
     c=find(class==i);
     other=find(find(class~=i));
     if size(c,1)>=3
         d=1;
     else 
         d=0;
     end
     if (size(c,1)==3 && ~(class(other(1))==class(other(2)) && class(other(1))==class(other(3))))
         d=1;
     end
     decision(i,j)=d;
     count=count+1;
    end
end
%% Plots of activities
figure;set(gcf,'name','Activity: Front Raise','numbertitle','off');
for i=1:sample_no
    subplot(2,3,1); plot(TRAINING_MVE_cam1(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6(i,:));title('Camera 6');
    hold on;
end
figure; set(gcf,'name','Activity: Sitting','numbertitle','off')
for i=sample_no+1:2*sample_no
    subplot(2,3,1); plot(TRAINING_MVE_cam1(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6(i,:));title('Camera 6');
    hold on;
end

figure; set(gcf,'name','Activity: Standing','numbertitle','off')
for i=2*sample_no+1:3*sample_no
    subplot(2,3,1); plot(TRAINING_MVE_cam1(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6(i,:));title('Camera 6');
    hold on;
end

figure; set(gcf,'name','Activity: Writing','numbertitle','off');
for i=3*sample_no+1:4*sample_no
    subplot(2,3,1); plot(TRAINING_MVE_cam1(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6(i,:));title('Camera 6');
    hold on;
end