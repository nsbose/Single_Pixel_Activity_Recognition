function  activity_estimation_final(activity)
%TRAINING_final must be a cell where first n_usr rows are act 1
%the next n_usr rows are act 2 ... 
load('TRAINING_final15.mat');
% TRAINING_MVE_cam(i)_final is an array where 10*first n_usr rows are act 1
%the next n_usr rows are act 2 ... 10 samples per activity per user
%no of rows in TRAINING_MVE_cam(i)_final are 4*10*n_usr
n_usr=size(TRAINING_MVE_final,1)/4;
% sounds for detection
[ANR,fs]=audioread('ANR.mp3');     
[sit,~]=audioread('sit.mp3');    
[stand,~]=audioread('stand.mp3');    
[front,~]=audioread('front.mp3');    
[write,~]=audioread('write.mp3');   

% sounds for authentication
% [recog,~]=audioread('recog.mp3');  
% [nel,~]=audioread('nel.mp3');  
% [sid,~]=audioread('sid.mp3');  
% [naved,~]=audioread('naved.mp3');  
% [rohan,~]=audioread('rohan.mp3'); 
% [UNF,fs]=audioread('UNF.mp3');   


activity_interp=zeros(6,40);%initializing the activity to a standard format
activity__interp_MVE=zeros(6,40);

%interpolation and Mean Variance Equalization of the activity
for i=1:6
    activity_interp(i,1:40)=interp1(1:size(activity(i,:),2),activity(i,:), linspace(1,size(activity(i,:),2),40),'pchip');
    activity__interp_MVE(i,1:40)=(activity_interp(i,:) - mean(activity_interp(i,:))) ./ var(activity_interp(i,:));
end
       %generating groups(classes) based on the number of users in the
       %training file
     group = [ones(10*n_usr,1); 2*ones(10*n_usr,1); 3*ones(10*n_usr,1); 4*ones(10*n_usr,1)];
     class=zeros(6,1);
     %knn classification on samples from each camera
     class(1)=knnclassify(activity__interp_MVE(1,:),TRAINING_MVE_cam1_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(1,:),TRAINING_MVE_cam1_final);
     D(1)= min(dist); usr_row(1)=find(dist==min(dist));
     
     class(2)=knnclassify(activity__interp_MVE(2,:),TRAINING_MVE_cam2_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(2,:),TRAINING_MVE_cam2_final);
     D(2)= min(dist); usr_row(2)=find(dist==min(dist));
    
     class(3)=knnclassify(activity__interp_MVE(3,:),TRAINING_MVE_cam3_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(3,:),TRAINING_MVE_cam3_final);
     D(3)= min(dist); usr_row(3)=find(dist==min(dist));
     
     class(4)=knnclassify(activity__interp_MVE(4,:),TRAINING_MVE_cam4_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(4,:),TRAINING_MVE_cam4_final);
     D(4)= min(dist); usr_row(4)=find(dist==min(dist));
     
     class(5)=knnclassify(activity__interp_MVE(5,:),TRAINING_MVE_cam5_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(5,:),TRAINING_MVE_cam5_final);
     D(5)= min(dist); usr_row(5)=find(dist==min(dist));
     
     class(6)=knnclassify(activity__interp_MVE(6,:),TRAINING_MVE_cam6_final,group,1,'cityblock');
     [~,dist]=knnsearch(activity__interp_MVE(6,:),TRAINING_MVE_cam6_final);
     D(6)= min(dist); usr_row(6)=find(dist==min(dist));
     
     %c(i) stores the number of cameras that support activity i 
     c(1)=size(find(class(:)==1),1);
     c(2)=size(find(class(:)==2),1);
     c(3)=size(find(class(:)==3),1);
     c(4)=size(find(class(:)==4),1);
     %which_act stores the activity that corresponds to max camera support
     which_act=find(c==max(c));
     
     if(size(which_act,2)>1) %if no unique acitivity is found 
         sound(ANR,fs);
    
     elseif which_act==1 %if act 1 has maximum support
         sound(front,fs);
     elseif which_act==2 %if act 2 has maximum support
         sound(sit,fs);
     elseif which_act==3 %if act 3 has maximum support
         sound(stand,fs);
     else 
         sound(write,fs); %if act 4 has maximum support
     end
     
     %code for user authentication
%      if size(which_act,2)==1
%      if var(D)<=0.02
%      %pause(4); sound(recog,fs);
%      COI=usr_row(find(class(:))==which_act);
%      COI=ceil(COI/10);COI=COI';
%      for u=1:n_usr
%      U(u)=size(find(COI==u),1);
%      end
%      if (size(find(U==max(U)),1)==1) %check that maximum val does not occur at more than 1 place
%      which_usr=find(U==max(U));
%                   %User not found
%      
%      if which_usr==1 
%          pause(2); sound(nel,fs);          %Neladri Authenticated 
%      end
%       if which_usr==2 
%         pause(2); sound(sid,fs);           %Siddhant Authenticated 
%       end
%       if which_usr==3 
%           pause(2); sound(naved,fs);       %Naved Authenticated
%       end
%      if which_usr==4 
%          pause(2); sound(rohan,fs);        %Rohan Authenticated    
%      end
%      %else
%      %    pause(2); sound(UNF,fs); 
% 
%      end
%     end
%     end
     
end


