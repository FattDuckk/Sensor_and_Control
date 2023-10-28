Files=dir("Students/Data1_Soft_Insertion_2/EM/");
for i=1:1387
   FileNames=Files(k).name
end

%%
for i=0:2001
filePath = fullfile('Students/Data2_Soft_pullback_1/EM/', sprintf('%d.txt', i));
Data2(i+1,:)=readtable(filePath);
% content=fread(fileID,'char')

end

% load EM_InData.mat