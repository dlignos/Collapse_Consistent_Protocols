%**************************************************************************
%  Collapse-consistent loading protocol for steel column testing
%**************************************************************************
    close all; clc; clear all;

    global Option1;
    global Option2;
    global Option3;

    
%**************************************************************************
% input parameters
%**************************************************************************
            
    fig = uifigure('Name','Select options','Position',[700 700 360 430]);
        bg = uibuttongroup(fig,'Title','Computation of ultimate deformation','Position', [10 265 340 150]);
            r1 = uiradiobutton(bg,'Text','User-defined input (HSS column)','Position',[20 100 330 20]);
            r2 = uiradiobutton(bg,'Text','User-defined input (wide flange column)','Position',[20 70 330 20]);
            r3 = uiradiobutton(bg,'Text','Modified IMK model parameters (HSS column)','Position',[20 40 330 20]);
            r4 = uiradiobutton(bg,'Text','Modified IMK model parameters (wide flange column)','Position',[20 10 330 20]);
        bg2 = uibuttongroup(fig,'Title','Axial load ratios','Position', [10 165 340 90]);
            r1 = uiradiobutton(bg2,'Text','User-defined input','Position',[20 40 200 20]);
            r2 = uiradiobutton(bg2,'Text','Equation (4.2) from Suzuki, Y. 2018 (dissertation)','Position',[20 10 330 20]);  
        bg3 = uibuttongroup(fig,'Title','Select ground motion type','Position', [10 65 340 90]);
            r1 = uiradiobutton(bg3,'Text','Near-fault','Position',[20 40 330 20]);
            r2 = uiradiobutton(bg3,'Text','Long-duration','Position',[20 10 330 20]);            
    btn = uibutton(fig,'push','Text','OK','Position',[240 10 100 40],'ButtonPushedFcn', @(btn,event) DataInputFunc(fig,bg,bg2,bg3));
        uiwait(fig); 

    if Option1 == 1 && Option2 == 1
       
        Fig = imread('Figure.jpg');
        imshow(Fig, 'Border', 'tight')
        f = figure (1);
        set(f,'Position', [450 690 400 330]);
        
        prompt = {'HSS depth-to-thickness ratio (D/t):', 'Expected yield stress of the steel column material [MPa]:',...
                  'Specify number of times to repeat the protocol:', ...
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Pre-capping plastic rotation, \theta_{p} [rad]:','Post-capping plastic rotation, \theta_{pc}  [rad]:', ...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on interior column:',...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on end column:',...
                  'Peak axial load ratio, P_{max}/P_{ye}, on end column due to transient effect:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','',''};
        options.Interpreter='tex';
        
        answer = inputdlg(prompt,title,[1 80],definput,options);

        close(f);
        
        for i = 1:9
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Fy = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);
        Theta_P = Temp_answer(5);
        Theta_PC = Temp_answer(6); 
        gPPy_int = Temp_answer(7);
        gPPy_end = Temp_answer(8);
        vPPy_end = Temp_answer(9); 

        
        
    elseif Option1 == 1 && Option2 == 2

        Fig = imread('Figure.jpg');
        imshow(Fig, 'Border', 'tight')
        f = figure (1);
        set(f,'Position', [450 690 400 330]);
        
        prompt = {'HSS depth-to-thickness ratio (D/t):', 'Expected yield stress of the steel column material [MPa]:',...
                  'Specify number of times to repeat the protocol:', ...                  
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Pre-capping plastic rotation, \theta_{p} [rad]:','Post-capping plastic rotation, \theta_{pc} [rad]:', ...
                  'Story height [m]:','Number of stories:','Specify beam length [m]:','Uniform gravity load on beam [kN/m]:','Base shear coefficient, V_{y}/W:', 'Expected axial yield strength of the steel column, P_{ye} [kN]:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);

        close(f);
        
        for i = 1:12
            Temp_answer(i) = str2num(answer{i});
        end 
        
        DTratio = Temp_answer(1);
        Fy = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);
        Theta_P = Temp_answer(5); 
        Theta_PC = Temp_answer(6);
        StoryHeight = Temp_answer(7);
        NumStory = Temp_answer(8);
        BeamSpan = Temp_answer(9);
        UnitGrav = Temp_answer(10); 
        BaseShearCoeff = Temp_answer(11);
        Py = Temp_answer(12);

        
        
    elseif Option1 == 2 && Option2 == 1
       
        Fig = imread('Figure.jpg');
        imshow(Fig, 'Border', 'tight')
        f = figure (1);
        set(f,'Position', [450 690 400 330]);
        
        prompt = {'Local web slenderness ratio (h/tw):', 'Column member slenderness, L_{b}/r_{y}', ...
                  'Specify number of times to repeat the protocol:', ...          
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Pre-capping plastic rotation, \theta_{p} [rad]:','Post-capping plastic rotation, \theta_{pc}  [rad]:', ...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on interior column:',...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on end column:',...
                  'Peak axial load ratio, P_{max}/P_{ye}, on end column due to transient effect:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','',''};
        options.Interpreter='tex';
        
        answer = inputdlg(prompt,title,[1 80],definput,options);

        close(f);
        
        for i = 1:9
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Lbry = Temp_answer(2); 
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);
        Theta_P = Temp_answer(5);
        Theta_PC = Temp_answer(6);
        gPPy_int = Temp_answer(7);
        gPPy_end = Temp_answer(8); 
        vPPy_end = Temp_answer(9);      

        
    elseif Option1 == 2 && Option2 == 2

        Fig = imread('Figure.jpg');
        imshow(Fig, 'Border', 'tight')
        f = figure (1);
        set(f,'Position', [450 690 400 330]);
        
        prompt = {'Local web slenderness ratio (h/tw):', 'Column member slenderness, L_{b}/r_{y}', ...
                  'Specify number of times to repeat the protocol:', ...       
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Pre-capping plastic rotation, \theta_{p} [rad]:','Post-capping plastic rotation, \theta_{pc}  [rad]:', ...
                  'Story height [m]:','Number of stories:','Specify beam length [m]:','Uniform gravity load on beam [kN/m]:','Base shear coefficient, V_{y}/W:', 'Expected axial yield strength of the steel column, P_{ye} [kN]:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);

        close(f);
        
        for i = 1:12
            Temp_answer(i) = str2num(answer{i});
        end 
        
        DTratio = Temp_answer(1); 
        Lbry = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);
        Theta_P = Temp_answer(5);
        Theta_PC = Temp_answer(6);
        StoryHeight = Temp_answer(7);
        NumStory = Temp_answer(8);
        BeamSpan = Temp_answer(9);
        UnitGrav = Temp_answer(10);
        BaseShearCoeff = Temp_answer(11);
        Py = Temp_answer(12);     
        

        
    elseif Option1 == 3 && Option2 == 1
        
        prompt = {'HSS depth-to-thickness ratio (D/t):', 'Expected yield stress of the steel column material [MPa]:',...
                  'Specify number of times to repeat the protocol:', ...
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on interior column:',...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on end column:',...
                  'Peak axial load ratio, P_{max}/P_{ye}, on end column due to transient effect:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);
        
        for i = 1:7
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Fy = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);  
        gPPy_int = Temp_answer(5);
        gPPy_end = Temp_answer(6);
        vPPy_end = Temp_answer(7);   
        

        
    elseif Option1 == 3 && Option2 == 2
        
        prompt = {'HSS depth-to-thickness ratio (D/t):', 'Expected yield stress of the steel column material [MPa]:',...
                  'Specify number of times to repeat the protocol:', ...
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Story height [m]:','Number of stories:','Specify beam length [m]:','Uniform gravity load on beam [kN/m]:','Base shear coefficient, V_{y}/W:', 'Expected axial yield strength of the steel column, P_{ye} [kN]:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);

        for i = 1:10
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Fy = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);     
        StoryHeight = Temp_answer(5);
        NumStory = Temp_answer(6);
        BeamSpan = Temp_answer(7);
        UnitGrav = Temp_answer(8);
        BaseShearCoeff = Temp_answer(9);
        Py = Temp_answer(10);  

       

    elseif Option1 == 4 && Option2 == 1
        
        prompt = {'Local web slenderness ratio (h/tw):', 'Column member slenderness, L_{b}/r_{y}', ...
                  'Specify number of times to repeat the protocol:', ...
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on interior column:',...
                  'Gravity-induced axial load ratio, P_{g}/P_{ye}, on end column:',...
                  'Peak axial load ratio, P_{max}/P_{ye}, on end column due to transient effect:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);
        
        for i = 1:7
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Lbry = Temp_answer(2); 
        NumRepeat = Temp_answer(3); 
        ElasticRotation = Temp_answer(4); 
        gPPy_int = Temp_answer(5);
        gPPy_end = Temp_answer(6);
        vPPy_end = Temp_answer(7);

        
    elseif Option1 == 4 && Option2 == 2
        
        prompt = {'Local web slenderness ratio (h/tw):', 'Column member slenderness, L_{b}/r_{y}', ...
                  'Specify number of times to repeat the protocol:', ...
                  'Elastic rotation, \theta_{y} [rad]:', ...
                  'Story height [m]:','Number of stories:','Specify beam length [m]:','Uniform gravity load on beam [kN/m]:','Base shear coefficient, V_{y}/W:', 'Expected axial yield strength of the steel column, P_{ye} [kN]:',...
                  };
        title = 'Input parameters';
        definput = {'','','','','','','','','','',''};
        options.Interpreter='tex';
        answer = inputdlg(prompt,title,[1 80],definput,options);

        for i = 1:10
            Temp_answer(i) = str2num(answer{i});
        end 

        DTratio = Temp_answer(1);
        Lbry = Temp_answer(2);
        NumRepeat = Temp_answer(3);
        ElasticRotation = Temp_answer(4);
        StoryHeight = Temp_answer(5);
        NumStory = Temp_answer(6);
        BeamSpan = Temp_answer(7);
        UnitGrav = Temp_answer(8);
        BaseShearCoeff = Temp_answer(9);
        Py = Temp_answer(10);     

    end
    
    if Option3 == 1
        GMtype = 1;
    elseif Option3 == 2
        GMtype = 2;
    else
        GMtype = 0;
    end
    
    if Option1 == 1 || Option1 == 3
        if DTratio < 20.0
            f = warndlg('The steel column is not expected to deteriorate much due to the low local slenderness ratio (D/t < 20).','Warning');
            uiwait(f); 
        elseif DTratio > 40.0
            f = warndlg('The input D/t ratio is out-of-range (D/t <= 40.0).','Warning');
            uiwait(f); 
            return;
        end
    end
    
    if Option1 == 2 || Option1 == 4
        if DTratio < 16.0
            f = warndlg('The steel column is not expected to deteriorate much due to the low local slenderness ratio (h/tw < 16.0).','Warning');
            uiwait(f); 
        elseif DTratio > 55.0
            f = warndlg('The input h/tw ratio is out-of-range (h/tw <= 55.0).','Warning');
            uiwait(f); 
            return;
        end
    end 
    
    if Option1 == 4
        if Lbry < 38.4 || Lbry > 120.0
            f = warndlg('The input Lb/ry ratio is out-of-range (38.4 <= Lb/ry <= 120.0).','Warning');
            uiwait(f); 
            return;
        end
    end
    

    
    
    
%**************************************************************************
% Axial load variation
%**************************************************************************

    if Option2 == 2
        gPPy_end = (UnitGrav*BeamSpan*NumStory/2.0)/Py;
        vPPy_end = (BaseShearCoeff*UnitGrav*StoryHeight*NumStory)/2.0;

        Temp = 0.0;
        for j = 1:NumStory
            Temp = Temp+sqrt(1-(j-1)/NumStory)+sqrt(1-j/NumStory);
        end

        vPPy_end = vPPy_end*Temp/Py;

        gPPy_int = gPPy_end*2.0;
    end
    
    if Option1 == 1 || Option1 == 3
        if gPPy_int > 0.5
            f = warndlg('The input axial load ratio for interior column is out-of-range (0<= Pg/Pye <= 0.5).','Warning');
            uiwait(f); 
            return;
        end
    elseif Option1 == 2 || Option1 == 4
        if gPPy_int > 0.75
            f = warndlg('The input axial load ratio for interior column is out-of-range (0<= Pg/Pye <= 0.75).','Warning');
            uiwait(f); 
            return;
        end
    end
    
%**************************************************************************
% IMK back bone parameters
%**************************************************************************

    if Option1 == 1 
        Theta_M = Theta_P+Theta_PC/2.0; 
        
        Lambda = 3012*((DTratio)^(-2.49))*((1-gPPy_end)^(3.51))*((Fy/380)^(-0.2));
        
    elseif Option1 == 2
        Theta_M = Theta_P+Theta_PC/2.0; 
        
        if gPPy_end <= 0.35
            Lambda = 25500.0*(DTratio^(-2.14))*(Lbry^(-0.53))*((1-gPPy_end)^(4.92));
        else
            Lambda = 26800.0*(DTratio^(-2.3))*(Lbry^(-1.3))*((1-gPPy_end)^(1.19));
        end
        
    elseif Option1 == 3
        Theta_P = 0.614*((DTratio)^(-1.05))*((1-gPPy_end)^(1.18))*((Fy/380)^(-0.11));
        Theta_PC = 13.82*((DTratio)^(-1.22))*((1-gPPy_end)^(3.04))*((Fy/380)^(-0.15));
        Lambda = 3012*((DTratio)^(-2.49))*((1-gPPy_end)^(3.51))*((Fy/380)^(-0.2));
        Theta_M = Theta_P+Theta_PC/2.0; 
    elseif Option1 == 4
        Theta_P = 294.0*(DTratio^(-1.7))*(Lbry^(-0.7))*((1-gPPy_end)^(1.6));
        if Theta_P > 0.2
            Theta_P = 0.2;
        end
        Theta_PC = 90.0*(DTratio^(-0.8))*(Lbry^(-0.8))*((1-gPPy_end)^(2.5));
        if Theta_PC > 0.3
            Theta_PC = 0.3;
        end
        
        if gPPy_end <= 0.35
            Lambda = 25500.0*(DTratio^(-2.14))*(Lbry^(-0.53))*((1-gPPy_end)^(4.92));
        else
            Lambda = 268000.0*(DTratio^(-2.3))*(Lbry^(-1.3))*((1-gPPy_end)^(1.19));
        end
        
        Theta_M = Theta_P+Theta_PC/2.0; 
    end
    
   
%**************************************************************************
% Lateral loading protocol - Normalized plastic defomration amplitude
%**************************************************************************

    if GMtype == 1
        if Option1 == 1 || Option1 == 3
            if DTratio <= 27.0
                ProtocolType = 1;
            elseif DTratio > 27.0
                ProtocolType = 2;
            end
        elseif Option1 == 2 || Option1 == 4
            if DTratio <= 35.0
                ProtocolType = 1;
            elseif DTratio > 35.0
                ProtocolType = 2;
            end
        end
    elseif GMtype == 2
        if Option1 == 1 || Option1 == 3
            if DTratio <= 27.0
                ProtocolType = 3;
            elseif DTratio > 27.0
                ProtocolType = 4;
            end
        elseif Option1 == 2 || Option1 == 4
            if DTratio <= 35.0
                ProtocolType = 3;
            elseif DTratio > 35.0
                ProtocolType = 4;
            end
        end
    end
            
    if ProtocolType == 1
        NumExcursion = 18;

        NormTheta(1) = 0;
        NormTheta(2) = 0.05;
        NormTheta(3) = -0.05;
        NormTheta(4) = 0.05;
        NormTheta(5) = -0.05;
        NormTheta(6) = 0.15;
        NormTheta(7) = -0.15;
        NormTheta(8) = 0.15;
        NormTheta(9) = -0.15;
        NormTheta(10) = 0.4;
        NormTheta(11) = -0.15;
        NormTheta(12) = 0.13;
        NormTheta(13) = 0.03;
        NormTheta(14) = 0.13;
        NormTheta(15) = 0.03;
        NormTheta(16) = 0.13;
        NormTheta(17) = 0.03;
        NormTheta(18) = 0.08;
        
        CoeffLambda = 1.15;
        
    elseif ProtocolType == 2
        NumExcursion = 20;

        NormTheta(1) = 0;
        NormTheta(2) = 0.1;
        NormTheta(3) = -0.1;
        NormTheta(4) = 0.1;
        NormTheta(5) = -0.1;
        NormTheta(6) = 0.2;
        NormTheta(7) = -0.2;
        NormTheta(8) = 0.2;
        NormTheta(9) = -0.2;
        NormTheta(10) = 1.0;
        NormTheta(11) = -0.4;
        NormTheta(12) = 0.8;
        NormTheta(13) = 0.15;
        NormTheta(14) = 0.45;
        NormTheta(15) = 0.15;
        NormTheta(16) = 0.45;
        NormTheta(17) = 0.15;
        NormTheta(18) = 0.45;
        NormTheta(19) = 0.15;
        NormTheta(20) = 0.3;
        
        CoeffLambda = 1.3;
        
    elseif ProtocolType == 3
        NumExcursion = 38;
        
        NormTheta(1) = 0;
        NormTheta(2) = 0.02;
        NormTheta(3) = -0.02;
        NormTheta(4) = 0.02;
        NormTheta(5) = -0.02;
        NormTheta(6) = 0.05;
        NormTheta(7) = -0.05;
        NormTheta(8) = 0.05;
        NormTheta(9) = -0.05;
        NormTheta(10) = 0.05;
        NormTheta(11) = -0.05;
        NormTheta(12) = 0.15;
        NormTheta(13) = -0.15;
        NormTheta(14) = 0.05;
        NormTheta(15) = -0.05;
        NormTheta(16) = 0.05;
        NormTheta(17) = -0.05;
        NormTheta(18) = 0.15;
        NormTheta(19) = -0.15;
        NormTheta(20) = 0.3;
        NormTheta(21) = -0.1;
        NormTheta(22) = 0.07;
        NormTheta(23) = 0.03;
        NormTheta(24) = 0.07;
        NormTheta(25) = 0.03;
        NormTheta(26) = 0.07;
        NormTheta(27) = 0.03;
        NormTheta(28) = 0.1;
        NormTheta(29) = 0;
        NormTheta(30) = 0.1;
        NormTheta(31) = 0;
        NormTheta(32) = 0.1;
        NormTheta(33) = 0;
        NormTheta(34) = 0.1;
        NormTheta(35) = 0;
        NormTheta(36) = 0.1;
        NormTheta(37) = 0;
        NormTheta(38) = 0.05;
        
        CoeffLambda = 1.25;
        
    elseif ProtocolType == 4
        NumExcursion = 42;
        
        NormTheta(1) = 0;
        NormTheta(2) = -0.05;
        NormTheta(3) = 0.05;
        NormTheta(4) = -0.05;
        NormTheta(5) = 0.05;
        NormTheta(6) = -0.15;
        NormTheta(7) = 0.15;
        NormTheta(8) = -0.15;
        NormTheta(9) = 0.15;
        NormTheta(10) = -0.15;
        NormTheta(11) = 0.15;
        NormTheta(12) = -0.15;
        NormTheta(13) = 0.15;
        NormTheta(14) = -0.5;
        NormTheta(15) = 0.5;
        NormTheta(16) = -0.15;
        NormTheta(17) = 0.15;
        NormTheta(18) = -0.15;
        NormTheta(19) = 0.15;
        NormTheta(20) = -0.15;
        NormTheta(21) = 0.15;
        NormTheta(22) = -0.15;
        NormTheta(23) = 0.15;
        NormTheta(24) = -0.15;
        NormTheta(25) = 0.15;
        NormTheta(26) = -0.15;
        NormTheta(27) = 0.8;
        NormTheta(28) = -0.1;
        NormTheta(29) = 0.4;
        NormTheta(30) = 0.1;
        NormTheta(31) = 0.4;
        NormTheta(32) = 0.1;
        NormTheta(33) = 0.4;
        NormTheta(34) = 0.1;
        NormTheta(35) = 0.4;
        NormTheta(36) = 0.1;
        NormTheta(37) = 0.5;
        NormTheta(38) = 0;
        NormTheta(39) = 0.5;
        NormTheta(40) = 0;
        NormTheta(41) = 0.5;
        NormTheta(42) = 0.25;
        
        CoeffLambda = 1.35;
        
    end 

    itemp = NumExcursion;
    NumExcursion_Phase1 = NumExcursion;
    
    for i = 1:NumRepeat-1
        jtemp = NormTheta(itemp);
        for j = 2:NumExcursion
            itemp = itemp+1;
            NormTheta(itemp) = jtemp+NormTheta(j);
        end
    end
    
    NumExcursion = itemp;
    NumProtocolLat = itemp;
    
    
%**************************************************************************
% Lateral loading protocol - Absolute plastic defomration amplitude
%**************************************************************************
    MaxTheta = 0.00;
    for i = 1:NumExcursion_Phase1
        if MaxTheta < abs(NormTheta(i)*Theta_M)
            MaxTheta = abs(NormTheta(i)*Theta_M);
        end
    end
    
    if MaxTheta > 0.08
        Theta_M = Theta_M*(0.08/MaxTheta);        
    end

    %*************************************************************************************************************************
     Theta_M = 0.06; %********************************************************************************************************
    %*************************************************************************************************************************

    for i = 1:NumProtocolLat
        ProtocolLat(i) = NormTheta(i)*Theta_M;
        Theta_Lat(i) = NormTheta(i)*Theta_M;
        if i == 1
            CumTheta_Lat(i) = abs(Theta_Lat(i));
        else
            CumTheta_Lat(i) = CumTheta_Lat(i-1)+abs(Theta_Lat(i)-Theta_Lat(i-1));
        end
        
        if i == 1
            Theta_Lat_Ela(i) = 0;
            
        elseif i == 2
            if Theta_Lat(i) > 0
                Theta_Lat_Ela(i) = Theta_Lat(i) + ElasticRotation;
            else
                Theta_Lat_Ela(i) = Theta_Lat(i) - ElasticRotation;
            end
        else
            if Theta_Lat(i)-Theta_Lat(i-1) > 0
                Theta_Lat_Ela(i) = Theta_Lat(i) + ElasticRotation;
            else
                Theta_Lat_Ela(i) = Theta_Lat(i) - ElasticRotation;
            end
        end
        
        PPye_int(i) = gPPy_int*-1;
    end

%**************************************************************************
% Axial loading protocol
%**************************************************************************

    CumRot(1) = 0.00;
    beta(1) = (Lambda*CoeffLambda-CumRot(1))/(Lambda*CoeffLambda);
    
    %initial back bone 
    PPyP2Ini = vPPy_end;
    PPyP3Ini = 0.4*PPyP2Ini;
    PPyP4Ini = PPyP2Ini/Theta_PC*(1.5*Theta_P+Theta_PC);
    
    pcStiffIni = -PPyP2Ini/Theta_PC;
 
    itemp = 0;
    for i = 2:NumProtocolLat
        if ProtocolLat(i)-ProtocolLat(i-1) > 0
            PPy2 = PPyP2Ini*beta(i-1);
            PPy4 = PPyP4Ini*beta(i-1);

            pcStiff = pcStiffIni*beta(i-1);

            cPPy = PPy2;
            cTheta = ProtocolLat(i-1);
            
            dPPy = PPy2;
            dTheta = (PPy2-PPy4)/pcStiff;

            rPPy = PPyP3Ini;
            rTheta = (PPyP3Ini-PPy4)/pcStiff;

            uPPy = PPyP3Ini;
            uTheta = 1.0;

            if ProtocolLat(i-1) >= dTheta
                cPPy = pcStiff*ProtocolLat(i-1)+PPy4;
                cTheta = ProtocolLat(i-1);

                dPPy = pcStiff*ProtocolLat(i-1)+PPy4;
                dTheta = ProtocolLat(i-1);
            end
            
            if ProtocolLat(i-1) >= rTheta
                cPPy = rPPy;
                cTheta = ProtocolLat(i-1);

                dPPy = rPPy;
                dTheta = ProtocolLat(i-1);
                
                rPPy = rPPy;
                rTheta = ProtocolLat(i-1);
            end
            
            if beta(i-1) < 0.4
                cPPy = rPPy;
                cTheta = ProtocolLat(i-1);

                dPPy = rPPy;
                dTheta = ProtocolLat(i-1);
                
                rPPy = rPPy;
                rTheta = ProtocolLat(i-1);
            end
            
            Thetay1 = ElasticRotation;

            itemp = itemp+1;
            Step(itemp) = itemp;
            
            Theta(itemp) = cTheta+Thetay1;
            ThetaPlastic(itemp) = cTheta;
            PPy(itemp) = cPPy;
            

            if ProtocolLat(i) > dTheta
                itemp = itemp+1;
                Step(itemp) = itemp;
                Theta(itemp) = dTheta+Thetay1;
                ThetaPlastic(itemp) = dTheta;
                PPy(itemp) = dPPy; 
                if ProtocolLat(i) > rTheta
                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = rTheta+Thetay1;
                    ThetaPlastic(itemp) = rTheta;
                    PPy(itemp) = rPPy; 

                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = ProtocolLat(i)+Thetay1;
                    ThetaPlastic(itemp) = ProtocolLat(i);
                    PPy(itemp) = rPPy; 
                else
                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = ProtocolLat(i)+Thetay1;
                    ThetaPlastic(itemp) = ProtocolLat(i);
                    PPy(itemp) = pcStiff*ProtocolLat(i)+PPy4;
                end
            else
                itemp = itemp+1;
                Step(itemp) = itemp;
                Theta(itemp) = ProtocolLat(i)+Thetay1;
                ThetaPlastic(itemp) = ProtocolLat(i);
                PPy(itemp) = cPPy;
            end

        else
            PPy2 = -PPyP2Ini*beta(i-1);
            PPy4 = -PPyP4Ini*beta(i-1);

            pcStiff = pcStiffIni*beta(i-1);

            cPPy = PPy2;
            cTheta = ProtocolLat(i-1);
            
            dPPy = PPy2;
            dTheta = (PPy2-PPy4)/pcStiff;

            rPPy = -PPyP3Ini;
            rTheta = (-PPyP3Ini-PPy4)/pcStiff;

            uPPy = -PPyP3Ini;
            uTheta = -1.0;

            if ProtocolLat(i-1) <= dTheta
                cPPy = pcStiff*ProtocolLat(i)+PPy4;
                cTheta = ProtocolLat(i-1);

                dPPy = pcStiff*ProtocolLat(i)+PPy4;
                dTheta = ProtocolLat(i-1);
            end 
            
            if ProtocolLat(i-1) <= rTheta
                cPPy = rPPy;
                cTheta = ProtocolLat(i-1);

                dPPy = rPPy;
                dTheta = ProtocolLat(i-1);
                
                rPPy = rPPy;
                rTheta = ProtocolLat(i-1);
            end 
            
            if beta(i-1) < 0.4
                cPPy = rPPy;
                cTheta = ProtocolLat(i-1);

                dPPy = rPPy;
                dTheta = ProtocolLat(i-1);
                
                rPPy = rPPy;
                rTheta = ProtocolLat(i-1);
            end
            
            Thetay2 = ElasticRotation;
            
            itemp = itemp+1;
            Step(itemp) = itemp;
            
            Theta(itemp) = cTheta-Thetay2;
            ThetaPlastic(itemp) = cTheta;
            PPy(itemp) = cPPy;
            
            if ProtocolLat(i) < dTheta
                itemp = itemp+1;
                Step(itemp) = itemp;
                Theta(itemp) = dTheta-Thetay2;
                ThetaPlastic(itemp) = dTheta;
                PPy(itemp) = dPPy; 
                if ProtocolLat(i) < rTheta
                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = rTheta-Thetay2;
                    ThetaPlastic(itemp) = rTheta;
                    PPy(itemp) = rPPy; 

                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = ProtocolLat(i)-Thetay2;
                    ThetaPlastic(itemp) = ProtocolLat(i);
                    PPy(itemp) = rPPy; 
                else
                    itemp = itemp+1;
                    Step(itemp) = itemp;
                    Theta(itemp) = ProtocolLat(i)-Thetay2;
                    ThetaPlastic(itemp) = ProtocolLat(i);
                    PPy(itemp) = pcStiff*ProtocolLat(i)+PPy4;
                end
            else
                itemp = itemp+1;
                Step(itemp) = itemp;
                Theta(itemp) = ProtocolLat(i)-Thetay2;
                ThetaPlastic(itemp) = ProtocolLat(i);
                PPy(itemp) = cPPy;
            end

        end
        
        CumRot(i) = CumRot(i-1)+abs(ProtocolLat(i)-ProtocolLat(i-1));
        beta(i) = (Lambda*CoeffLambda-CumRot(i))/(Lambda*CoeffLambda);
        

        PPy_second(i) = cPPy;
    end
    
    Step2(1) = 0;
    Theta2(1) = 0;
    Theta3(1) = 0;
    Theta4(1) = 0;
    Theta5(1) = 0;
    
    PPy2(1) = gPPy_end;
       
    Step2(2) = 1;
    Theta2(2) = Theta(1);
    Theta3(2) = abs(Theta(1));
    Theta4(2) = ThetaPlastic(1); 
    Theta5(2) = abs(ThetaPlastic(1));
    
    PPy2(2) = PPy(1)+gPPy_end;

    
    jtemp = 2;
    for i = 2:itemp
        if Theta(i) == Theta(i-1) && PPy(i) == PPy(i-1)
        else
            jtemp = jtemp+1;
            Step2(jtemp) = jtemp-1;
            Theta2(jtemp) = Theta(i);
            Theta3(jtemp) = Theta3(jtemp-1)+abs(Theta2(jtemp)-Theta2(jtemp-1));
            Theta4(jtemp) = ThetaPlastic(i);
            Theta5(jtemp) = Theta5(jtemp-1)+abs(Theta4(jtemp)-Theta4(jtemp-1));
            
            PPy2(jtemp) = PPy(i)+gPPy_end;
        end
    end
    NumStep2 = jtemp;

    
    PPy_second(1) = gPPy_end*-1;
    for i = 2:NumProtocolLat
        PPy_second(i) = (PPy_second(i)+gPPy_end)*-1;
    end


%**************************************************************************
% Plot
%**************************************************************************

    extension  = 'fig';
    
    onoff2 = 'on';
    FigClose2 = 2;
    
   
    figH = figure('visible', onoff2, 'position', [100, 800, 1000, 300],'Name','Figure-Lateral protocol','NumberTitle','off'); 
    
        p = uipanel('Parent',figH,'BorderType','none','BackgroundColor','white'); 
        p.Title = 'Defined lateral loading protocol'; 
        p.TitlePosition = 'centertop'; 
        p.FontSize = 12;
        p.FontWeight = 'bold'; 
        
        subplot(1,2,1,'Parent',p);     
            plot(0:NumExcursion-1, NormTheta(1:NumExcursion) ,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Excursion number')
            ylabel('Normalized plastic deformaiton amplitude')
            grid on;
            set(figH,'color','white');

        subplot(1,2,2,'Parent',p);     
            plot(0:NumExcursion-1, Theta_Lat(1:NumExcursion) ,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Excursion number')
            ylabel('Plastic deformaiton amplitude [rad]')
            grid on;
            set(figH,'color','white');
    
    saveas(figH,char(['Output-Lateral protocol.' extension]) ,extension)

    if FigClose2 == 1
        close(figH)  
    end  
            
            
            
    figH = figure('visible', onoff2, 'position', [100, 100, 1000, 600],'Name','Figure-End column','NumberTitle','off'); 
    
        p = uipanel('Parent',figH,'BorderType','none','BackgroundColor','white'); 
        p.Title = 'Loading protocol for end column'; 
        p.TitlePosition = 'centertop'; 
        p.FontSize = 12;
        p.FontWeight = 'bold'; 
        
        subplot(2,2,1,'Parent',p);     
            plot(1:NumStep2, Theta2(1:NumStep2) ,'k','linewidth',0.5)
            hold on;
            
            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Load step')
            ylabel('Rotation [rad]')
            grid on;
            set(figH,'color','white');
           
        subplot(2,2,3,'Parent',p);
            plot(1:NumStep2, PPy2(1:NumStep2)*-1 ,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Load step')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');

        subplot(2,2,2,'Parent',p);    
            plot(Theta2(1:NumStep2),PPy2(1:NumStep2)*-1,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Rotation [rad]')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');
            
        subplot(2,2,4,'Parent',p);
            plot(Theta5(1:NumStep2),PPy2(1:NumStep2)*-1,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Cumulative plastic rotation [rad]')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');
    
    saveas(figH,char(['Output-End column.' extension]) ,extension)

    if FigClose2 == 1
        close(figH)  
    end     
            
            
            
    figH = figure('visible', onoff2, 'position', [1200, 100, 1000, 600],'Name','Figure-Interior column','NumberTitle','off'); 
    
        p = uipanel('Parent',figH,'BorderType','none','BackgroundColor','white'); 
        p.Title = 'Loading protocol for interior column'; 
        p.TitlePosition = 'centertop'; 
        p.FontSize = 12;
        p.FontWeight = 'bold'; 
        
        subplot(2,2,1,'Parent',p);      
            plot(1:NumExcursion, Theta_Lat_Ela(1:NumExcursion) ,'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Load step')
            ylabel('Rotation [rad]')
            grid on;
            set(figH,'color','white');
           
        subplot(2,2,3,'Parent',p);
            plot(1:NumExcursion, PPye_int(1:NumExcursion),'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Load step')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');

        subplot(2,2,2,'Parent',p);      
            plot(Theta_Lat_Ela(1:NumExcursion), PPye_int(1:NumExcursion),'k','linewidth',0.5)
            hold on;

            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Rotation [rad]')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');
            
        subplot(2,2,4,'Parent',p);     
            plot(CumTheta_Lat(1:NumExcursion), PPye_int(1:NumExcursion),'k','linewidth',0.5)
            hold on;
            
            set(0,'DefaultAxesFontName', 'Times New Roman')
            xlabel('Cumulative plastic rotation [rad]')
            ylabel('Axial load ratio, P/P_{ye}')
            grid on;
            set(figH,'color','white');
    
    saveas(figH,char(['Outtput-Interior column.' extension]) ,extension)

    if FigClose2 == 1
        close(figH)  
    end        
            
            
                
%**************************************************************************
% Text data output
%**************************************************************************
    
    fid1 = fopen('Output-TXT.txt','wt');

        fprintf(fid1, '%s\t','Excursion number');
        fprintf(fid1, '%s\t','Normalized plastic deformation amplitude');
        fprintf(fid1, '%s\t','Plastic deformation amplitude');

        fprintf(fid1, '%s\t','Load step (end column)');
        fprintf(fid1, '%s\t','Rotation (end column)');
        fprintf(fid1, '%s\t','Axial load ratio (end column)');

        fprintf(fid1, '%s\t','Load step (interior column)');
        fprintf(fid1, '%s\t','Rotation (interior column)');
        fprintf(fid1, '%s\n','Axial load ratio (interior column)');

        for i = 1:NumStep2
            if i <= NumExcursion
                fprintf(fid1,'%d\t',i);
                fprintf(fid1,'%f\t',NormTheta(i));
                fprintf(fid1,'%f\t',Theta_Lat(i));

                fprintf(fid1,'%d\t',i);
                fprintf(fid1,'%f\t',Theta2(i));
                fprintf(fid1,'%f\t',PPy2(i)*-1);

                fprintf(fid1,'%d\t',i);
                fprintf(fid1,'%f\t',Theta_Lat_Ela(i));
                fprintf(fid1,'%f\n',gPPy_int*-1);
            else
                fprintf(fid1,'%s\t','');
                fprintf(fid1,'%s\t','');
                fprintf(fid1,'%s\t','');

                fprintf(fid1,'%d\t',i);
                fprintf(fid1,'%f\t',Theta2(i));
                fprintf(fid1,'%f\t',PPy2(i)*-1);

                fprintf(fid1,'%s\t','');
                fprintf(fid1,'%s\t','');
                fprintf(fid1,'%s\n','');
            end
        end
        
    fclose(fid1);
    

    
    

%**************************************************************************
% Function for radio button
%**************************************************************************
function DataInputFunc(fig,bg,bg2,bg3)
    global Option1;
    global Option2;
    global Option3;
    
    Text1 = bg.SelectedObject.Text;
        if Text1 == "User-defined input (HSS column)"
            Option1 = 1;
        elseif Text1 == "User-defined input (wide flange column)"
            Option1 = 2;
        elseif Text1 == "Modified IMK model parameters (HSS column)"
            Option1 = 3;
        elseif Text1 == "Modified IMK model parameters (wide flange column)"
            Option1 = 4;
        else
            Option1 = 5;
        end
        
    Text2 = bg2.SelectedObject.Text;
        if Text2 == "User-defined input"
            Option2 = 1;
        elseif Text2 == "Equation (4.2) from Suzuki, Y. 2018 (dissertation)"
            Option2 = 2;
        else
            Option2 = 3;
        end
        
    Text3 = bg3.SelectedObject.Text;
        if Text3 == "Near-fault"
            Option3 = 1;
        elseif Text3 == "Long-duration"
            Option3 = 2;
        else
            Option3 = 3;
        end
        
	uiresume(fig);
    close(fig);

end

    
    
    
    
    
    
    
    
