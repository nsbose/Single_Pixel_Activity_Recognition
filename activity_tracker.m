%% Connection setup
%EC720
%Code developed by Siddhant Sharma & Neladri Bose
%This is the activity detection algorithm
%It estimates background for a cound of 12 and returns the lighting
%condition based on the average of the sum of gradients for 12 frames
%After 12 frames a user can enter the room and the system detets activity
%start and stop by a beep sound. The activity frames are recorded in ACT{}
%This can be used to get training data; comment line <>
% As a standard measure, Store the training frames as front sit stand and
% write (or choose your unique <activityname>)
% save file <username>_<activityname> i.e eg sam_front sam_write sam_sit
% Once you get all name_activity files , run Decision_CCR_metric




clc;clear all;
urls={'tcp://192.168.1.202:2335/{0}/ColorSensor'};  
urllength=length(urls);
global connections
connections=cell(urllength,1);
for i=1:urllength
connections{i}=RobotRaconteur.Connect(urls{i});
end
disp('The connection is made');
%% Background Estimation
disp('Estimating Background till count of 12');
gradient_back=zeros(6,1);
for back=1:12; %taking the first 12 frames for background
for j=1:length(connections)
    	
    	readings=double(connections{j}.ReadSensors()); % Reads the data from the sensors, %produces an 8(muxboards)x8(outputs)x6(reading values) array of values
    	
	end
	back %counts upto 12 frames during runtime
    
    %6 sensors, R,G,B values for each
	RGBs(1:3,1:3)=readings(1,1:3,1:3);  %cameras 1,2,3 
	RGBs(4,1:3)=readings(1,5,1:3); %camera #4 is made camera #5
	RGBs(5,1:3)=readings(1,4,1:3); %camera #5 is made camera #4
	RGBs(6,1:3)=readings(1,6,1:3);  %camera 6
	
    %converts to grayscale values
	g_val(1:6) = 0.299*RGBs(1:6,1) + 0.578*RGBs(1:6,2) + 0.114*RGBs(1:6,3);
	g_val = g_val';           %transposes matrix
   
    
    % stores values as integers
	background_pixels(1:6,back) = double(int16(g_val(1:6)));
    
    
    %gradiant calculation for every frame starting frame 2
    if (back >= 2)
        gradient_back = background_pixels(:,back)-background_pixels(:,back-1);
    end
   
        %sequentially storing gradiants in an array
        background(:,back)=background_pixels(1:6,back);
        %summing gradiants on all cameras 
        g(back)=sum(abs(gradient_back));
        %summing the sum of gradiants on all frames
        G=sum(g);
   
        
        %last frame on test
    if back==12
        background_sum=floor(G/2); %average of sum of gradiant for 6 frames(1 second)
     %setting 3 threshold values for activity detection based on background
        if background_sum<23       %night
            disp('Low Lighting Condition');
            thresh3= background_sum+18;
            thresh2=thresh3+30;
            thresh1=thresh2+50;
        elseif background_sum<55   %normal cloudy
             disp('Medium Lighting Condition');
            thresh3= background_sum+60;
            thresh2=thresh3+80;
            thresh1=thresh2+40;
        elseif background_sum<150  %normal sunny 66 82  71  69 32 84 52 53 64 25 104 23 64 68 113 73 98 72 51 50 26 28 44 25 36 54 67 119 106
             disp('High Lighting Condition');
            thresh3= background_sum+100;
            thresh2=thresh3+120;
            thresh1=thresh2+80;
%         elseif  background_sum<800                      %bright/sunny 213 136 672 592 569 340 404 794 162 307 328 440 417 437
%             disp('Very high lighting condition');
%             thresh3= background_sum+250;
%             thresh2=thresh3+300;
%             thresh1=thresh2+250;
        else
            disp('Ending program because its too noisy');
        end
    end
end
    clearvars g_val RGBs back G j; %clearing useless variables
%% Runtime
%Variables being initialized
i=1; %this acts as a switch for detecting each activity (i=0 at the end of an activity)
k=0; %stores the number of activities performed since the program was run
fps=6; % it should be 6.5 fps
cams=6;
ACT{1,10}={}; %stores activities in a cell

while (i==1)
i=0; k=k+1;
count = 1; %stores the frame count 
window = 1; %keeps oscillating from 1 to 6, to get the gradiants over 1 sec 
pixel_data= zeros(cams,fps); %stores camera pixels info
gradient_1=zeros(6,1); %gradiant per frame 
 temp=0; %this increments after activity starts
 len=6;  %this increments after activity progresses
g=zeros(1,len);
buffer=zeros(cams,len); %stores the pixel values in a buffer for 
a_rolloff=0; %this switch gets active when activity progression falls thresh2 
%(but greater than thresh3)
%roll_off_buffer=zeros(6,3); %stores frames after apple=1 limit=3 frames
while(i==0)
	
	for j=1:length(connections)
    	
    	readings=double(connections{j}.ReadSensors()); 
% Reads the data from the sensors, 
%produces an 8(muxboards)x8(outputs)x6(reading values) array of values
    	
	end
	
	RGBs(1:3,1:3)=readings(1,1:3,1:3);  %6 sensors, R,G,B values for each
	RGBs(4,1:3)=readings(1,5,1:3);
	RGBs(5,1:3)=readings(1,4,1:3);
	RGBs(6,1:3)=readings(1,6,1:3);
	%converts to grayscale values
	g_val(1:6) = 0.299*RGBs(1:6,1) + 0.578*RGBs(1:6,2) + 0.114*RGBs(1:6,3);
	g_val = g_val'; %transposes matrix
    % stores values as integers
	pixel_data(1:cams,count) = double(int16(g_val(1:cams)));
    %gradiant calculation
    
    if (count >= 2)
        gradient_1 = pixel_data(:,count)-pixel_data(:,count-1);
    end
    if (window<=6)
        buffer(:,window)=pixel_data(1:cams,count);
        g(window)=sum(abs(gradient_1));
        G=sum(g);
    end
  
    if (G>=thresh1 && temp==0)  % threshold to start activity
        disp('Activity started')
        beep;
        temp=count; %temp switch activited
        activity(:,1:6)=buffer; 
        %start of activity first 6 pixels stored from buffer to activity
    end
    
    if (G>=thresh2 && G < thresh1 && temp==0)
        %act is between(tresh2,thresh1)
        disp('Activity about to be started')
    end
    
    if (G>=thresh3 && G < thresh2 && temp==0) 
        %act is between (tresh3,thresh2)
        disp('Residual motion') %frames not stored
    end
    
    if (G<thresh3 && temp==0) 
        %act is less than tresh3 and activity is not progressing
        %i=i+1;
        disp(' No motion :Background') %frames not stored
    end
    
    if (G<thresh3 && temp~=0)  %very unusual case : 
  %act is less than tresh3 and activity is progressing
        %i=i+1;
        disp('static during activity') %frames not stored
    end
    
    if (G>=thresh2 && a_rolloff==0 && temp~=0)
        %act is greater than tresh2 
        len=len+1; %len incremented to store more frames in activity
        activity(:,len)=pixel_data(:,count);  %frames stored
        disp('Activity in progress')
        
    elseif (G>thresh3 && G<thresh2 && temp~=0)    
%jitter during rolloff (do not get back to activity switch enabled)
        %roll_off_buffer(1:6,apple+1)=pixel_data(:,count);
        a_rolloff=a_rolloff+1;
        disp('You are ending your activity')
    end
    
    if (G>=thresh2 && a_rolloff~=0 && temp~=0) %very unusual case : 
%when act falls below thresh2 and further jumps to greater than thresh2
        disp('You should not be moving now')
    end
    %very unusual case when rolloff does not exceed 2
    
    if ((G<=thresh3 && temp~=0) || (a_rolloff>=3 && temp~=0)) 
    %conditions of ending activity can be modified here
    %Acitvity must end after 3 frames of being below thresh2
        disp('Activity Ended')
        beep;
        %roll_off=(count-temp)-(len+1); %gives rolloff time
        ACT{1,k}=activity;
        activity_estimation_final(activity) %calling the estimation block
        clearvars activity;
        %call KNN function
        i=i+1;
    end

    count = count+1; % update count of frame
	window=window+1; %update gradiant window
    if window==7
        window=1; %let window oscillate from 1 to 6
    end
end
end
%%
% test=1;
% for i=1:2:19
% if test<11
% sit{1,test}=ACT{1,i};
% stand{1,test}=ACT{1,i+1};
% test=test+1;
% end
% end


% for i=1:1:10
% front{1,i}=ACT{1,i};
% end
% 
% for i=1:1:10
% write{1,i}=ACT{1,i};
% end
