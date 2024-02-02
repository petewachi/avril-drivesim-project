% @File      : accelerations.m
% @Contact   : info@vi-grade.com
% @License   : PROPRIETARY/CONFIDENTIAL (https://www.vi-grade.com/license.txt)
% @Copyright : (c) 2006-2023, VI-grade GmbH, Darmstadt, Germany, All Rights Reserved
% ----------------------------------------------------------------------------------
function accelerations (positive_acc_threshold , negative_acc_threshold)


% positive_acc_threshold = 0.3;
% negative_acc_threshold = -0.6;

fig = uifigure('Position',[100 500 500 180],'Name','LKA variants Positive Lat Accelerations [g]');
uit=uitable(fig,'Data',(evalin('base','result_max_accelerations')),'Position',[20 20 450 120]);
uit.ColumnName=cell(num2cell(strcat(string(evalin('base','variant_approaching_speed'))," m/s^2")));
uit.RowName = cell(num2cell(strcat(string(evalin('base','variant_LKA_activation'))," m")));

[row,col] =find(evalin('base','result_max_accelerations') > positive_acc_threshold);
try
    s = uistyle('BackgroundColor',[1 0.2 0.2]);
    addStyle(uit,s,'cell',[row,col]);
catch
    disp('<strong>You need matlab version > 2019b to visualize colored thresholds in acceleration report</strong>');
    uit.BackgroundColor = [0.85,0.85,1];
end

[row,col] =find(evalin('base','result_max_accelerations') < positive_acc_threshold);
try
    s = uistyle('BackgroundColor','#77AC30');
    addStyle(uit,s,'cell',[row,col]);
catch
    uit.BackgroundColor = [0.85,0.85,1];
end



fig = uifigure('Position',[700 500 500 180],'Name','LKA variants Negative Lat Accelerations [g]');
uit=uitable(fig,'Data',(evalin('base','result_min_accelerations')),'Position',[20 20 450 120]);
uit.ColumnName=cell(num2cell(strcat(string(evalin('base','variant_approaching_speed'))," m/s^2")));
uit.RowName = cell(num2cell(strcat(string(evalin('base','variant_LKA_activation'))," m")));

[row,col] =find(evalin('base','result_min_accelerations') < negative_acc_threshold);
try
    s = uistyle('BackgroundColor',[1 0.2 0.2]);
    addStyle(uit,s,'cell',[row,col]);
catch
    uit.BackgroundColor = [0.85,0.85,1];
end


[row,col] =find(evalin('base','result_min_accelerations') > negative_acc_threshold);
try
    s = uistyle('BackgroundColor','#77AC30');
    addStyle(uit,s,'cell',[row,col]);
catch
    uit.BackgroundColor = [0.85,0.85,1];
end
