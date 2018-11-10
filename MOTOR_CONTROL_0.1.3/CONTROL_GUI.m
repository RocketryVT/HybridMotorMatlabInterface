function varargout = CONTROL_GUI(varargin)
%CONTROL_GUI MATLAB code file for CONTROL_GUI.fig
%      CONTROL_GUI, by itself, creates a new CONTROL_GUI or raises the existing
%      singleton*.
%
%      H = CONTROL_GUI returns the handle to a new CONTROL_GUI or the handle to
%      the existing singleton*.
%
%      CONTROL_GUI('Property','Value',...) creates a new CONTROL_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to CONTROL_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CONTROL_GUI('CALLBACK') and CONTROL_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CONTROL_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CONTROL_GUI

% Last Modified by GUIDE v2.5 06-May-2018 17:05:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CONTROL_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CONTROL_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CONTROL_GUI is made visible.
function CONTROL_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for CONTROL_GUI
handles.output = hObject;

 %set(hObject,'Units','Pixels','Position',get(0,'ScreenSize'));
 
% Update handles structure
guidata(hObject, handles);





% UIWAIT makes CONTROL_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function [handles, varargout] = CONTROL_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglearm.
function togglearm_Callback(hObject, eventdata, handles)
% hObject    handle to togglearm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglearm

    config

    if strcmp(handles.togglefire.Enable,'off')
        MODE = 1;
        
        % Enable FIRE button
        handles.togglefire.Enable = 'on';
        
        % Disable LOAD button
        handles.loaddatabutton.Enable = 'off';
        
        if (IS_CONNECTED)
%             fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04 0x01'), 'uint8');
            set_Arduino_Mode(1);
        end
    else
        MODE = 0;
        
        % Disable FIRE button
        handles.togglefire.Enable = 'off';
        
        % Enable LOAD button
        handles.loaddatabutton.Enable = 'on';

        if (IS_CONNECTED)
%             fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04 0x00'), 'uint8');
            set_Arduino_Mode(0);
        end
        
    end
    

% --- Executes on button press in togglefire.
function togglefire_Callback(hObject, eventdata, handles)
% hObject    handle to togglefire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglefire

    config

    if strcmp(handles.pushbuttonstop.Enable,'off')
        MODE = 2;
        
        % Enable STOP button
        handles.pushbuttonstop.Enable = 'on';

        % Disable ARM button
        handles.togglearm.Enable = 'off';

        % TODO: FIRE actions
        if (IS_CONNECTED)
%             fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04 0x02'), 'uint8');
            set_Arduino_Mode(2);
            update_input_buffer();
            parse_input_buffer();
        end
    else
        MODE = 1;
        
        % Disable STOP button
        handles.pushbuttonstop.Enable = 'off';

        % Enable ARM button
        handles.togglearm.Enable = 'on';

        % TODO: FIRE actions (when disabled)
        if (IS_CONNECTED)
%             fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04 0x01'), 'uint8');
            set_Arduino_Mode(1);
            update_input_buffer();
            parse_input_buffer();
        end
       
    end


% --- Executes on button press in pushbuttonstop.
function pushbuttonstop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    config

    MODE = 0;
    
    % Disable all buttons
    handles.togglearm.Enable = 'off';
    handles.togglearm.Value = 0;
    handles.togglefire.Enable = 'off';
    handles.togglefire.Value = 0;
    handles.pushbuttonstop.Enable = 'off';
    handles.simulatebutton.Enable = 'off';
    handles.savebutton.Enable = 'on';
    

    % TODO: STOP actions
    if (IS_CONNECTED)
        set_Arduino_Mode(0);
        update_input_buffer();
        parse_input_buffer();
        
        handles.ModeTextBox.String = num2str(ARDMODE);
    end
    
    


function pressurecombustiontext_Callback(hObject, eventdata, handles)
% hObject    handle to pressurecombustiontext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pressurecombustiontext as text
%        str2double(get(hObject,'String')) returns contents of pressurecombustiontext as a double


% --- Executes during object creation, after setting all properties.
function pressurecombustiontext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressurecombustiontext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end



function pressureoxidizertext_Callback(hObject, eventdata, handles)
% hObject    handle to pressureoxidizertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pressureoxidizertext as text
%        str2double(get(hObject,'String')) returns contents of pressureoxidizertext as a double


% --- Executes during object creation, after setting all properties.
function pressureoxidizertext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressureoxidizertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temperaturecombustiontext_Callback(hObject, eventdata, handles)
% hObject    handle to temperaturecombustiontext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperaturecombustiontext as text
%        str2double(get(hObject,'String')) returns contents of temperaturecombustiontext as a double


% --- Executes during object creation, after setting all properties.
function temperaturecombustiontext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperaturecombustiontext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function temperatureoxidizertext_Callback(hObject, eventdata, handles)
% hObject    handle to temperatureoxidizertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperatureoxidizertext as text
%        str2double(get(hObject,'String')) returns contents of temperatureoxidizertext as a double


% --- Executes during object creation, after setting all properties.
function temperatureoxidizertext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperatureoxidizertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function thrusttext_Callback(hObject, eventdata, handles)
% hObject    handle to thrusttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thrusttext as text
%        str2double(get(hObject,'String')) returns contents of thrusttext as a double


% --- Executes during object creation, after setting all properties.
function thrusttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thrusttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in criticalerrorlistbox.
function criticalerrorlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to criticalerrorlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns criticalerrorlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from criticalerrorlistbox


% --- Executes during object creation, after setting all properties.
function criticalerrorlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to criticalerrorlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in dataerrorslistbox.
function dataerrorslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to dataerrorslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dataerrorslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dataerrorslistbox


% --- Executes during object creation, after setting all properties.
function dataerrorslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataerrorslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function textcommandedit_Callback(hObject, eventdata, handles)
% hObject    handle to textcommandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textcommandedit as text
%        str2double(get(hObject,'String')) returns contents of textcommandedit as a double

    config
    
    try
        % Obtain string from command window
        str = get(hObject, 'String');
        
        % Send Hex Command
        if handles.radiobuttonhexflag.Value
            bytes = hex_to_byte_array(str);
            fwrite(SERIAL_PORT, bytes);
        else % Send ASCII command
            fprintf(SERIAL_PORT, '%s\n', str);
        end
    catch err
        fprintf('Error on textcommandedit_Callback\n');
        err, beep
    end
    
    % Save handles structure
    guidata(hObject,handles);
   


% --- Executes during object creation, after setting all properties.
function textcommandedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textcommandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonhexflag.
function radiobuttonhexflag_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonhexflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonhexflag


% --- Executes on button press in simulatebutton.
function simulatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to simulatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of simulatebutton

    config

    if strcmp(handles.pushbuttonstop.Enable,'off')
        MODE = 5;
        
        % Enable STOP button
        handles.pushbuttonstop.Enable = 'on';

        % Disable ARM button
        handles.togglearm.Enable = 'off';

        % Disable LOAD button
        handles.loaddatabutton.Enable = 'off';
        
        % TODO: SIMULATE actions
        if (IS_CONNECTED)
            fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04 0x05'), 'uint8');
            update_input_buffer();
            parse_input_buffer();
        end
    else
        MODE = 0;
        
        % Disable STOP button
        handles.pushbuttonstop.Enable = 'off';

        % Enable ARM button
        handles.togglearm.Enable = 'on';

        % TODO: SIMULATE actions (when disabled)
        if (IS_CONNECTED)
        end
    end


% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fstr, pstr] = uiputfile('*.csv');
if fstr == 0
    return;
end

if fstr
    save_data(strcat(pstr,fstr));
    return
end

config

% --- Executes on button press in loaddatabutton.
function loaddatabutton_Callback(hObject, eventdata, handles)
% hObject    handle to loaddatabutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

config

[fstr, pstr] = uigetfile('*.mat');
if (fstr)
    load(strcat(pstr,fstr));
    SIM_VER = simdatver;
    SIM_DATA = data;
end

handles.simulatebutton.Enable = 'on';



function ModeTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to ModeTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ModeTextBox as text
%        str2double(get(hObject,'String')) returns contents of ModeTextBox as a double


% --- Executes during object creation, after setting all properties.
function ModeTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModeTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temperaturepostcombustion_Callback(hObject, eventdata, handles)
% hObject    handle to temperaturepostcombustion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperaturepostcombustion as text
%        str2double(get(hObject,'String')) returns contents of temperaturepostcombustion as a double


% --- Executes during object creation, after setting all properties.
function temperaturepostcombustion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperaturepostcombustion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
