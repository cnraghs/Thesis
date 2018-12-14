function hOut = TextLocation(textString,varargin)

l = legend(textString,varargin{:});
t = annotation('textbox','Interpreter','latex','FontSize',12, 'BackgroundColor', 'w', 'EdgeColor', 'k','FitBoxToText','on');
t.String = textString;
t.Position = l.Position;
delete(l);
%t.LineStyle = 'None';

if nargout
    hOut = t;
end
end

