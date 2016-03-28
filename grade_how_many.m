% 1.  Initialize an array with the prefix names to be tested
prefix = {'data/ant/images/ant_'; ...
    'data/intersection/images/intersection_'; ...
    'data/people/images/people_'};

% gt files
gtFiles = {'data/ant/gt.xlsx';...
    'data/intersection/gt.xlsx';...
    'data/people/gt.xlsx'};

% 2.  Load the frame numbers to be tested from each video.
numFrame = [00001, 03597; 00001,03600; 00001,00496];


total_score = 0; % Final Score
  
% 3.  Test
% For each video
for i = 1:size(prefix,1)
    t = cputime; % start timer
    
    % Get number start and end frame for current video
    f0 = numFrame(i,1); f1 = numFrame(i,2);
    
    %load gt
    gt_all = xlsread(char(gtFiles(i)));
    
    gt_ct = gt_all(1:5,1:2);
    
    % train how many
    x = train_how_many (char(prefix(i)), f0, f1, gt_ct );
    
    %frames for grading
    ct_f = gt_all(6:10,1)';
    
    % Call the algorithm.
    ctr = how_many(char(prefix(i)), x, ct_f);
    
    execution_time = cputime - t;
    
    if execution_time > 300 % 5 minutes per video
        fprintf ( 'video[%d] Took > 5 minutes and is not considered for grade.\n', i);
        continue
    end
    
    gt = gt_all(6:10, 2)';
    for j = 1:numel(ctr)
        score = max((gt(j) - abs(gt(j)-ctr(j)))/gt(j), 0);
        total_score = total_score + score;
        fprintf ( 'video[%d] - frame[%d] - GT[%d] vs ME[%d] - score[%f] - total score[%f]\n', i ,ct_f(j),gt(j),ctr(j) ,score, total_score);
    end
    fprintf ( 'video[%d] - took [%f]sec\n', i ,execution_time);
    
        
end

fprintf ( 'Total score [%f]\n', total_score);