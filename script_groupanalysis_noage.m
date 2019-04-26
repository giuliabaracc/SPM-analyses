datadir='C:\Users\gbaracchini\Documents\gng_fmri_data';
cd(datadir)
ids = {'980' '2571' '4772' '5167' '5234' '5584' '6189' '6425' '7808' '7927' '8007' '8074' '8633' '9065' '10460' '11107' '11483' '11494' '11597' '11660' '11733' '11769' '12268' '12447' '12721' '12791' '12805' '13040' '13461' '14916'};

load C:/Users/gbaracchini/Documents/gng_fmri_data/spm_second_level/N30_Groupanalysis_noage/NoGo1_Go2/batch.mat

for i = 1:length(ids)      
    matlabbatch{1, 3}.spm.stats.con.consess{1, 1}.tcon.name = 'NoGo1+Go2 - NoGo2+Go1' ; 
    matlabbatch{1, 1}.spm.stats.factorial_design.dir = {sprintf('%s/spm_second_level/N30_Groupanalysis_noage/NoGo1+Go2 - NoGo2+Go1/',datadir)} ;  
    matlabbatch{1, 1}.spm.stats.factorial_design.des.t1.scans(i,1) = {strcat('C:\Users\gbaracchini\Documents\gng_fmri_data\spm_first_level\', ids{i}, '\con_0010.img,1')};
end

eval(['save ', sprintf('%s/spm_second_level/N30_Groupanalysis_noage/NoGo1+Go2 - NoGo2+Go1/gng_2nd_level_batch_N30.mat',datadir),' matlabbatch'])
%clear matlabbatch
   
