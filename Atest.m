
%%
clear 
clf
% for j=1:2002
%     clearvars -except j
%     clf
%     A = imread(sprintf('%d.jpg',j));
    A = imread('2002.jpg');
    A = im2bw(A);
    imshow(A)
%     Rmin = 20;
%     Rmax = 100;
%     [centersBright, radiiBright] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','bright');
%     viscircles(centersBright, 50,'Color','b');
    A(1:50,:) = 0;
    A(350:435,350:435) = 0;
    A(375:400,:) = 0;
    A(:,375:400) = 0;
    
    imshow(A)
    %%
    B = detectHarrisFeatures(A,"FilterSize",65);
    [features,valid_corners] = extractFeatures(A,B);
    hold on
    plot(valid_corners)
    C = valid_corners.Location;
    % C(67:length(C),:) =[];
    % scatter(C(:,1),C(:,2))
    
    %%
    %{
    tempC = C;
    finalC = zeros(length(C),2);
    finalC(1,:) = C(1,:);
    distance = zeros(length(tempC)-1,1);
    Switch = true;
    k = 1;
    while(Switch == true)    
        for i = 1:length(tempC)-1
            distance(i) = sqrt((tempC(1,1)-tempC(i+1,1))^2+(tempC(1,2)-tempC(i+1,2))^2); 
        end
        minD = min(distance);
        position = find(minD == distance);
        if position+1 ~= 2
            temp = tempC(2,:);
            tempC(2,:) = tempC(position+1,:);
            tempC(position+1,:) = temp;
            finalC(k+1,:) = tempC(2,:);
        elseif position + 1 == 2
            finalC(k+1,:) = tempC(2,:);
        end
        k = k + 1;
        tempC(1,:) = [];
        distance = zeros(length(tempC)-1,1);
        if length(tempC) == 2
            finalC(k+1,:) = tempC(2,:);
            Switch = false;
            disp('Done!')
        end
    
    end
    finalC(length(finalC)+1,:) = finalC(1,:);
    plot(finalC(:,1),finalC(:,2));
    %}
    %%
%     Xvalue = (min(finalC(:,1)) + max(finalC(:,1)))/2;
%     Yvalue = (min(finalC(:,2)) + max(finalC(:,2)))/2;
%     yline(Yvalue,'-.b')
%     xline(Xvalue,'-.r')
    %%
    Xvalue = (min(C(:,1)) + max(C(:,1)))/2;
    Yvalue = (min(C(:,2)) + max(C(:,2)))/2;
    yline(Yvalue,'-.b')
    xline(Xvalue,'-.r')
    
%     %%
%     saveas(gcf,sprintf('%d.jpg',j))
%     disp(j)
% end

