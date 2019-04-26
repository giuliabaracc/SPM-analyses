datadir='R:\projects\fmri147\fmri147_shared\eprime_data'; %where your files are
cd(datadir)
ids = {'980' '8633' '9065' '8074'}; %your IDs: just do 2-3 at first to see if the script works



for i = 1:length(ids)
    readtable
    
    load gng_1st_level_example.mat %load your batch file = the one you have saved BEFORE running the job
    %here you have your conditions: point to the text files where you saved
    %your onsets
    correct= dlmread(sprintf('%s/fmri_onsets\goNoGo\correct_resp_only\%s_goNoGo_go1_correct_onsets.txt',datadir, ids{i})); 
    incorrect= dlmread(sprintf('%s/fmri_onsets\goNoGo\correct_resp_only\%s_goNoGo_go2_correct_onsets.txt',datadir, ids{i}));
    fixation= dlmread(sprintf('%s/fmri_onsets\goNoGo\correct_resp_only\%s_goNoGo_nogo1_correct_onsets.txt',datadir, ids{i}));
    
    %condition 1: do not change matlabbatch{1,1} as you go from one condition to the other: the second number in the
    %bracket is NOT your condition number but the module in your batch so:
    %{1,1} is model specification; {1,2} is model estimation; {1,3} is contrast manager
    matlabbatch{1,1}.spm.stats.fmri_spec.dir = {sprintf('%s/%s', datadir,ids{i})};
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans = strrep(matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans,'980',ids{i});
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,1).onset = correct;
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,1).duration = 4.5;
    
    %condition 2
    matlabbatch{1,1}.spm.stats.fmri_spec.dir = {sprintf('%s/%s', datadir,ids{i})};
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans = strrep(matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans,'980',ids{i});
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,2).onset = incorrect;
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,2).duration = 4.5;
    
    %condition 3
    matlabbatch{1,1}.spm.stats.fmri_spec.dir = {sprintf('%s/%s', datadir,ids{i})};
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans = strrep(matlabbatch{1,1}.spm.stats.fmri_spec.sess.scans,'980',ids{i});
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,3).onset = fixation;
    matlabbatch{1,1}.spm.stats.fmri_spec.sess.cond(1,3).duration = [461 473628 4181]; %here put your durations
    
    eval(['save ', sprintf('./jobs/%s_spmMask.mat',ids{i}),' matlabbatch']) %here put where the mask file lives
    
    clear matlabbatch
    clear onsets*
    
end

