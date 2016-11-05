%EC720
%Code developed by Siddhant Sharma & Neladri Bose
function  activity_estimation(activity) 
%This function should be used when only one user input is given as samples
%for multi user input first assimilate the data by running assimilate.m and
%then use function activity_estimation_final
%interp and MVE
load('siddhant.mat')
[ANR,fs]=audioread('ANR.mp3');     
[sit,fs]=audioread('sit.mp3');    
[stand,fs]=audioread('stand.mp3');    
[front,fs]=audioread('front.mp3');    
[write,fs]=audioread('write.mp3');    
activity_interp=zeros(6,40);
activity__interp_MVE=zeros(6,40);
for i=1:6
    activity_interp(i,1:40)=interp1(1:size(activity(i,:),2),activity(i,:), linspace(1,size(activity(i,:),2),40),'pchip');
    activity__interp_MVE(i,1:40)=(activity_interp(i,:) - mean(activity_interp(i,:))) ./ var(activity_interp(i,:));
end

     group = [ones(10,1); 2*ones(10,1); 3*ones(10,1); 4*ones(10,1)];
     class=zeros(6,1);
     class(1)=knnclassify(activity__interp_MVE(1,:),TRAINING_MVE_cam1,group,1,'cityblock');
     class(2)=knnclassify(activity__interp_MVE(2,:),TRAINING_MVE_cam2,group,1,'cityblock');
     class(3)=knnclassify(activity__interp_MVE(3,:),TRAINING_MVE_cam3,group,1,'cityblock');
     class(4)=knnclassify(activity__interp_MVE(4,:),TRAINING_MVE_cam4,group,1,'cityblock');
     class(5)=knnclassify(activity__interp_MVE(5,:),TRAINING_MVE_cam5,group,1,'cityblock');
     class(6)=knnclassify(activity__interp_MVE(6,:),TRAINING_MVE_cam6,group,1,'cityblock');
     c(1)=size(find(class==1),1);
     c(2)=size(find(class==2),1);
     c(3)=size(find(class==3),1);
     c(4)=size(find(class==4),1);
     %camera_support=max(c);
     which_act=find(c==max(c));
     if(size(which_act,2)>1)
         sound(ANR,fs);
     elseif which_act==1
         sound(front,fs);
     elseif which_act==2
         sound(sit,fs);
     elseif which_act==3
         sound(stand,fs);
     else 
         sound(write,fs);
     end
end


