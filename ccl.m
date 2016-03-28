function [ count ] = ccl( bwimage, minPixels )
%CCL Summary of this function goes here
%   Detailed explanation goes here

%     padded = padarray(bwimage,[1 1])
    labeled = zeros(size(bwimage));
    
    label = 1;
    equivTable = zeros(10000,2);

    for i = 1:1:size(bwimage,1)
        for j = 1:1:size(bwimage,2)
            
            %if the first row, set the top to be 0
            if i == 1
                imtop = 0;
            else
              imtop = bwimage(i-1,j);
              ltop = labeled(i-1,j); 
            end
            
            %If first col, set the left to be 0
            if j == 1
                imleft = 0;
            else
              imleft = bwimage(i,j-1);
              lleft = labeled(i,j-1);
            end
            
            
            %If pixel is foreground
            if bwimage(i,j) == 1
                
                %No foreground
                if imtop == 0 && imleft == 0
%                     disp('New Label');
                    labeled(i,j) = label;
                    label = label + 1;
                                  
                %Two Foreground 
                elseif imtop == 1 && imleft == 1
                    %same labels
                    if ltop == lleft
                        labeled(i,j) = ltop;
                    %diff labels
                    else 
                       labeled(i,j) = min(ltop,lleft);
                       %Add to equiv table matrix.
                       equivTable(max(ltop,lleft), 2) = min(ltop,lleft);                  
                    end
       
                 %One Foreground
                elseif imtop == 1
                    labeled(i,j) = ltop;    
                elseif imleft == 1
                    labeled(i,j) = lleft;
                end
                
            end
            
        end   
    end


    
    %Second Pass
    for i = 1:1:size(bwimage,1)
        for j = 1:1:size(bwimage,2)    
            x = labeled(i,j);
            y=0;
            %Update until no more equivalents
            while x ~= 0
                y = x;
                x = equivTable(x,2);
            end   
            labeled(i,j) = y;   
        end
    end

    %Count labels and remove ones that do not have enough pixels to count
    count = 0;
    a = unique(labeled);
    out = [a,histc(labeled(:),a)];
%     disp(out);
    for i = 2:size(out,1)
        if out(i,2) > minPixels
            count = count + 1;
        end
    end
    
    
    
    
    
end

