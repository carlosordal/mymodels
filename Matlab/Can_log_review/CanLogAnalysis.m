
%number of fields on Struct
dt = unique(diff(lyftctrlSigTable.ESP_A2.Time));
numel(fieldnames(lyftctrlSigTable));
mean(lyftctrlSigTable.ESP_A2.Time);
%constants.' names{i} 

%finalData.s7.bm5.rSync
%s7_bm5.rSync = finalData.s7.bm5.rSync
%s7_bm5.mSync = finalData.s7.bm5.mSync
%s8_bm5.rSync = finalData.s8.bm5.rSync
%s8_bm5.mSync = finalData.s8.bm5.mSync%

%so structure is:
%finaldata.s(i).bm(j).rSync
%finaldata.s(i).bm(j).mSync
% for i = 1:numel(finaldata.s)
%     for j = 1:numel(finaldata.s(i).bm)        
%         rsync = finaldata.s(i).bm(j).rSync;
%         msync = finaldata.s(i).bm(j).mSync;
%         %... do something 
%     end
% end

for i = 1:numel(fieldnames(lyftctrlSigTable)) 
        rsync = finaldata.s(i).bm(j).rSync;
        msync = finaldata.s(i).bm(j).mSync;
        %... do something 
    end
end




