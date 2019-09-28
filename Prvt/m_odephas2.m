function status = m_odephas2(t,y,flag)
%ODEPHAS2 2-D phase plane ODE output function.
%   When the string 'odephas2' is passed to an ODE solver as the 'OutputFcn'
%   property, i.e. options = odeset('OutputFcn','odephas2'), the solver
%   calls ODEPHAS2(T,Y) after every timestep.  The ODEPHAS2 routine plots
%   the first two components of the solution it is passed as it is computed,
%   adapting the axis limits of the plot dynamically.  To plot two
%   particular components, specify their indices in the 'OutputSel' property
%   passed to the ODE solver.
%   
%   At the start of integration, a solver calls ODEPHAS2(TSPAN,Y0,'init') to
%   initialize the output function.  After each integration step to new time
%   point T with solution vector Y the solver calls STATUS = ODEPHAS2(T,Y).
%   If the solver's 'Refine' property is greater than one (see ODESET), then
%   T is a column vector containing all new output times and Y is an array
%   comprised of corresponding column vectors.  The STATUS return value is 1
%   if the STOP button has been pressed and 0 otherwise.  When the
%   integration is complete, the solver calls ODEPHAS2([],[],'done').
%   
%   See also ODEPLOT, ODEPHAS3, ODEPRINT, ODE45, ODE15S, ODESET.

%   Mark W. Reichelt and Lawrence F. Shampine, 3-24-94
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 1.18 $  $Date: 1997/11/21 23:31:07 $

status = 0;                             % Assume stop button wasn't pushed.
chunk = 128;                            % Memory is allocated in chunks.

if nargin < 3 | isempty(flag)% odephas2(t,y)
  hndf=gcf;
  ud = get(hndf,'UserData');
  
  nt = length(t);
  
  %display current values
  strVal=sprintf('[%10.4f %10.4f](%f)',y(1,nt),y(2,nt),t(nt));
  set(findobj(hndf,'Tag','txtVal'),'String',strVal);
  
  % Append y to ud.y, allocating if necessary.
  chunk = max(chunk,nt);
  rows = size(ud.y,1);
  oldi = ud.i;
  newi = oldi + nt;
  if newi > rows
    ud.y = [ud.y; zeros(chunk,2)];
  end
  ud.y(oldi+1:newi,:) = y(1:2,:).';
  ud.i = newi;
  set(gcf,'UserData',ud);
  
  if ud.stop == 1                       % Has stop button been pushed?
    status = 1;
    odephas2([],[],'done');
  else
    % Rather than redraw all of the data every timestep, we will simply move
    % the line segments for the new data, not erasing.  But if the data has
    % moved out of the axis range, we redraw everything.
    xlim = get(gca,'xlim');
    ylim = get(gca,'ylim');
    % Replot everything if out of axis range or if just initialized.
    if (oldi == 1) | ...
          (min(y(1,:)) < xlim(1)) | (xlim(2) < max(y(1,:))) | ...
          (min(y(2,:)) < ylim(1)) | (ylim(2) < max(y(2,:)))
      set(ud.lines, ...
          'Xdata',ud.y(1:newi,1), ...
          'Ydata',ud.y(1:newi,2));
      set(ud.line, ...
          'Xdata',ud.y(oldi:newi,1), ...
          'Ydata',ud.y(oldi:newi,2));
    else
       % Plot only the new data.
      set(ud.line,'Color','b'); 
      set(ud.line, ...
          'Xdata',ud.y(oldi:newi,1), ...
          'Ydata',ud.y(oldi:newi,2), ...
          'Color','r');
    end
  end
  
else
  switch(flag)
  case 'init'                           % odephas2(tspan,y0,'init')
    ud.y = zeros(chunk,2);
    ud.i = 1;
    ud.y(1,:) = y(1:2).';
    ud.stop=0;
    % Rather than redraw all data at every timestep, we will simply move
    % the last line segment along, not erasing it.
    if ~ishold
    	 ud.lines = plot(y(1),y(2),'Color','b');
    	 hold on
    	 ud.line = plot(y(1),y(2),'Color','r','EraseMode','none');
    	 hold off
    else
       ud.lines = plot(y(1),y(2),'Color','b','EraseMode','none');
       ud.line = plot(y(1),y(2),'Color','r','EraseMode','none');
    end
    
    f = gcf;
    set(f,'UserData',ud);
 case 'done' % odephas2([],[],'done')
    f = gcf;
    ud = get(f,'UserData');
    ud.y = ud.y(1:ud.i,:);
    set(f,'UserData',ud);
    set(ud.lines, ...
        'Xdata',ud.y(:,1), ...
        'Ydata',ud.y(:,2),'Color','b');
  end
end

drawnow;
