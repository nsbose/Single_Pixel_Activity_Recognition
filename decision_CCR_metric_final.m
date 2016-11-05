%EC720
%Code developed by Siddhant Sharma & Neladri Bose
clc;clear all;
load('TRAINING_final20.mat'); %to be used for LOOCV for any number of users 
%%
count=1;
n_usr=size(TRAINING_MVE_final,1)/4;
group = [ones(10*n_usr,1); 2*ones(10*n_usr,1); 3*ones(10*n_usr,1); 4*ones(10*n_usr,1)];
%decision=[zeros(4,10)];
class=zeros(6,1);
usr_row=zeros(6,1);
rows=size(TRAINING_MVE_final,1);
for i=1:size(TRAINING_MVE_final,1)
    for j=1:10
     sample_MVE=TRAINING_MVE_final{i,j};
     [Y1,~] = removerows(TRAINING_MVE_cam1_final,'ind',count);
     [Y2,~] = removerows(TRAINING_MVE_cam2_final,'ind',count);
     [Y3,~] = removerows(TRAINING_MVE_cam3_final,'ind',count);
     [Y4,~] = removerows(TRAINING_MVE_cam4_final,'ind',count);
     [Y5,~] = removerows(TRAINING_MVE_cam5_final,'ind',count);
     [Y6,~] = removerows(TRAINING_MVE_cam6_final,'ind',count);
     [g,~] = removerows(group,'ind',count);
     class(1)=knnclassify(sample_MVE(1,:),Y1,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(1,:),Y1);
     D(1)= min(temp); usr_row(1)=find(temp==min(temp));
     class(2)=knnclassify(sample_MVE(2,:),Y2,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(2,:),Y2);
      D(2)= min(temp); usr_row(2)=find(temp==min(temp));
     class(3)=knnclassify(sample_MVE(3,:),Y3,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(3,:),Y3);
      D(3)= min(temp); usr_row(3)=find(temp==min(temp));
     class(4)=knnclassify(sample_MVE(4,:),Y4,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(4,:),Y4);
      D(4)= min(temp); usr_row(4)=find(temp==min(temp));
     class(5)=knnclassify(sample_MVE(5,:),Y5,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(5,:),Y5);
      D(5)= min(temp); usr_row(5)=find(temp==min(temp));
     class(6)=knnclassify(sample_MVE(6,:),Y6,g,15,'cityblock');
      [~,temp]=knnsearch(sample_MVE(6,:),Y6);
      D(6)= min(temp); usr_row(6)=find(temp==min(temp));
      
     big_class{i,j}=class(:,1);
     MAE{i,j}=D;
     
     %decision on activity
     c(1)=size(find(class(:)==1),1); %no of occurrances of activity 1
     c(2)=size(find(class(:)==2),1);
     c(3)=size(find(class(:)==3),1);
     c(4)=size(find(class(:)==4),1);
     which_act=find(c==max(c)); %position indicating maximum occrrance of activity
     
     if (size(which_act,2)==1 && which_act==ceil(i/n_usr))
         d=1;  %perfect decision
     end 
     if  (size(which_act,2)==1 && which_act~=ceil(i/n_usr))
         d=99999999;  %wrong activity was recognized
     end
     
     if  (size(which_act,2)>1)
         d=0;  %No majority formed/ No unique activity recognized
     end
     decision_activity(i,j)=d;

     %decision on user authentication
      if d==1
     COI=usr_row(find(class(:)==ceil(i/n_usr))); %cameras of interest using activity recognition
     COI=ceil(COI./10)';
     no_of_cameras_supporting_user_activity(i,j)=size(find(COI==mod(i,n_usr)),2);
      end
     count=count+1;
    end
end
%% Plots of activities
figure;set(gcf,'name','Activity: Front Raise','numbertitle','off');
for i=1:n_usr*10
    subplot(2,3,1); plot(TRAINING_MVE_cam1_final(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2_final(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3_final(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4_final(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5_final(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6_final(i,:));title('Camera 6');
    hold on;
end
figure; set(gcf,'name','Activity: Sitting','numbertitle','off')
for i=n_usr*10+1:n_usr*20
    subplot(2,3,1); plot(TRAINING_MVE_cam1_final(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2_final(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam2_final(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam3_final(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam4_final(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam5_final(i,:));title('Camera 6');
    hold on;
end

figure; set(gcf,'name','Activity: Standing','numbertitle','off')
for i=n_usr*20+1:n_usr*30
    subplot(2,3,1); plot(TRAINING_MVE_cam1_final(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2_final(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3_final(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4_final(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5_final(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6_final(i,:));title('Camera 6');
    hold on;
end

figure; set(gcf,'name','Activity: Writing','numbertitle','off');
for i=n_usr*30+1:n_usr*40
    subplot(2,3,1); plot(TRAINING_MVE_cam1_final(i,:));title('Camera 1');
    hold on;
    subplot(2,3,2); plot(TRAINING_MVE_cam2_final(i,:));title('Camera 2');
    hold on;
    subplot(2,3,3); plot(TRAINING_MVE_cam3_final(i,:));title('Camera 3');
    hold on;
    subplot(2,3,4); plot(TRAINING_MVE_cam4_final(i,:));title('Camera 4');
    hold on;
    subplot(2,3,5); plot(TRAINING_MVE_cam5_final(i,:));title('Camera 5');
    hold on;
    subplot(2,3,6); plot(TRAINING_MVE_cam6_final(i,:));title('Camera 6');
    hold on;
end

%% LOOCV
front_decision=decision_activity(1:n_usr,:);
front_success=size(find(front_decision(:)==1));front_success=(front_success(1,1)*100)./(n_usr*10);
front_anr=size(find(front_decision(:)==0));front_anr=(front_anr(1,1)*100)./(n_usr*10);
front_wrong=size(find(front_decision(:)==99999999));front_wrong=(front_wrong(1,1)*100)./(n_usr*10);
front_stats=[front_success,front_anr,front_wrong]

sit_decision=decision_activity(n_usr+1:2*n_usr,:);
sit_success=size(find(sit_decision(:)==1));sit_success=(sit_success(1,1)*100)./(n_usr*10);
sit_anr=size(find(sit_decision(:)==0));sit_anr=(sit_anr(1,1)*100)./(n_usr*10);
sit_wrong=size(find(sit_decision(:)==99999999));sit_wrong=(sit_wrong(1,1)*100)./(n_usr*10);
sit_stats=[sit_success,sit_anr,sit_wrong]

stand_decision=decision_activity(2*n_usr+1:3*n_usr,:);
stand_success=size(find(stand_decision(:)==1));stand_success=(stand_success(1,1)*100)./(n_usr*10);
stand_anr=size(find(stand_decision(:)==0));stand_anr=(stand_anr(1,1)*100)./(n_usr*10);
stand_wrong=size(find(stand_decision(:)==99999999));stand_wrong=(stand_wrong(1,1)*100)./(n_usr*10);
stand_stats=[stand_success,stand_anr,stand_wrong]



write_decision=decision_activity(3*n_usr+1:4*n_usr,:);
write_success=size(find(write_decision(:)==1));write_success=(write_success(1,1)*100)./(n_usr*10);
write_anr=size(find(write_decision(:)==0));write_anr=(write_anr(1,1)*100)./(n_usr*10);
write_wrong=size(find(write_decision(:)==99999999));write_wrong=(write_wrong(1,1)*100)./(n_usr*10);
write_stats=[write_success,write_anr,write_wrong]


total_decision=decision_activity;
total_success=size(find(total_decision(:)==1));total_success=(total_success(1,1)*100)./(n_usr*40);
total_anr=size(find(total_decision(:)==0));total_anr=(total_anr(1,1)*100)./(n_usr*40);
total_wrong=size(find(total_decision(:)==99999999));total_wrong=(total_wrong(1,1)*100)./(n_usr*40);
total_stats=[total_success,total_anr,total_wrong]
