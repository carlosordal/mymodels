function newFileName = fcn_RenameMatFiles(oldFileName)


[folder, baseFileName, extension] = fileparts(fullfile(blfPath, blfFile));
noSpaceName =  regexprep(baseFileName, ' ', '_');
newFilename = strcat(noSpaceName,'_cCan.mat');
newFilename = fullfile(blfPath, newFilename);
movefile( oldFilename, newFilename );

newFileName = 0;
end
