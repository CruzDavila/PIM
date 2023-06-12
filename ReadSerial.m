close all; clear all; clc;

delete(instrfind('Port','COM7'));

s = serialport('COM5',9600);

fclose all;

i = 0;
VAn = [0,0,0];
mag = 1;
VPos = [0,0,0]; 

fopen(s);

r = (2*pi)/360;

while 1

    for i = 0:1:200
        %fopen(s);
        hold on
    
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        
        VRA = fscanf (s,'%s');
        VA = textscan (VRA, '%f', 'Delimiter',',');
        VA = permute (VA{1}, [1,2,3]);
    
        VA(1) = VA(1);
        VA(2) = VA(2);
        VA(3) = VA(3);
    
        VA
    
        Vx = VA(1)*r;
        Vy = VA(2)*r;
        Vz = VA(3)*r;
    
        VPos(1) = VAn(1) + 1*cos(Vz)*cos(Vy) + (1*cos(Vx)*sin(Vz)+1*sin(Vx)*cos(Vz)*sin(Vy)) + (1*sin(Vx)*sin(Vz)-1*cos(Vx)*cos(Vz)*sin(Vy));
        VPos(2) = VAn(2) + 1*-cos(Vy)*sin(Vz) + (1*cos(Vx)*cos(Vz)-1*sin(Vx)*sin(Vz)*sin(Vy)) + (1*sin(Vx)*cos(Vz)+1*cos(Vx)*sin(Vz)*sin(Vy));
        VPos(3) = VAn(3) + 1* sin(Vy) + 1*-cos(Vy)*sin(Vx) + cos(Vy)*cos(Vx);
    
        plot3(0,0,0,'oblack')
        xlim = [-20 20];
        ylim = [-20 20];
        zlim = [-20 20];
        plot3([VAn(1) VPos(1)],[VAn(2) VPos(2)], [VAn(3) VPos(3)], '-r'); drawnow
        %%xlim([-100 100]);
        %%ylim([-100 100]);
        %%zlim([-100 100]);
    
        delete(instrfind('Port','COM9'));
        VAn = VPos;
        
       %fclose(s);
    end
    
    hold off
    plot3([VAn(1) VPos(1)],[VAn(2) VPos(2)], [VAn(3) VPos(3)], '-r'); drawnow

end