function m_dre(drefun,nbiter,y0,rParam)
%discrete recursive ecuation solver for attractor plotting (y[n]=drefun(y[n-1]))

Y=zeros(2,length(y0));
Y(1,:)=y0;
Y(2,:)=feval(drefun,y0,rParam);
ud.stop=0;%assume stop button wasn't pushed
%data to be ploted
if length(y0)==1
	ud.y=[Y(1) Y(2)];%first column x, second column y
else
	ud.y=Y(1:2,:);
end
ud.lines=[];%comet body - handles
ud.line=[];%comet head - handles
hndf=gcf;
set(hndf,'UserData',ud)

for n=2:nbiter
	%recursivity
	Y(1,:)=Y(2,:);
	Y(2,:)=feval(drefun,Y(1,:),rParam);
	ud=get(hndf,'UserData');
	%add new point
	if length(y0)==1
		ud.y=[ud.y;[ud.y(end,end) Y(2)]];%first column x, second column y
	else
		ud.y=[ud.y;Y(2,:)];
	end
	if n==2 %init
		ud.lines = plot(ud.y(:,1),ud.y(:,2),'Color','b');
		hold on
    	ud.line = plot(ud.y(:,1),ud.y(:,2),'Color','r','EraseMode','none');
		hold off
		%plot only dots ?
		if ~str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'))
			set(ud.lines,'LineStyle','none','Marker','.')
			set(ud.line,'LineStyle','none','Marker','.')
		end
	else %plot
		xlim = get(gca,'xlim');
    	ylim = get(gca,'ylim');
    	%Replot everything if out of axis range
    	if (ud.y(end,1) < xlim(1)) | (xlim(2) < ud.y(end,1)) | ...
           (ud.y(end,2) < ylim(1)) | (ylim(2) < ud.y(end,2))
      		set(ud.lines, ...
        	  'Xdata',ud.y(1:end-1,1), ...
           	  'Ydata',ud.y(1:end-1,2));
      		set(ud.line, ...
       	   	  'Xdata',ud.y(end-1:end,1), ...
        	  'Ydata',ud.y(end-1:end,2));
    	else
       		%Plot only the new data.
      		set(ud.line,'Color','b'); 
      		set(ud.line, ...
          		'Xdata',ud.y(end-1:end,1), ...
          		'Ydata',ud.y(end-1:end,2), ...
          		'Color','r');
		end
	end
	%display current values
  	strVal=sprintf('[%10.4f %10.4f](%u)',ud.y(end,1:2),n);
  	set(findobj(hndf,'Tag','txtVal'),'String',strVal)
	set(hndf,'UserData',ud)
	drawnow
	%check stop button
	if ud.stop break; end
end