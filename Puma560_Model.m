clear L
deg = pi/180;
L(1) = Revolute('d', 1, 'a', 0, 'alpha', 90*deg, ...
    'I', [0 0 0
    0 0 0
    0 0 0], ...
    'r', [0, 0, 0], ...
    'm', 0, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'qlim', [-180 180]*deg );

L(2) = Revolute('d', 0, 'a', 1, 'alpha', 0, ...
    'I', [0.0125 0 0
    0 0.8396 0
    0 0 0.8396], ...
    'r', [0, 0.5, 0], ...
    'm', 10, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'qlim', [-90 90]*deg );

L(3) = Revolute('d', 0, 'a', 1, 'alpha', 0,  ...
    'I', [0.0125 0 0
    0 0.8396 0
    0 0 0.8396], ...
    'r', [0, 0.5, 0], ...
    'm', 10, ...
    'Jm', 10e-4, ...
    'G', 500, ...
    'B', 10*10e-4, ...
    'qlim', [-90 90]*deg );

 RRR = SerialLink(L, 'name', 'RRR');

qz = [0 90*deg 0]; % zero angles, L shaped pose
qr = [0 pi/2 -pi/2]; % ready pose, arm up
qs = [0 0 -pi/2 0 0 0];
qn=[0 pi/4 pi 0 pi/4  0];

clear L

RRR.plot(qz)
%RRR.teach('rpy')

Jac = RRR.jacob0([0,0,0], 'trans'); %'rot' can be used as well. Its parameters are higher for 'hold' state
Grav1 = RRR.gravload([0,0,-90*deg]); %home
Grav2 = RRR.gravload([0,0,0]); %hold
  
F1 = Grav1.';
F2 = Grav2.';
Torque1 = Jac.'*F1
Torque2 = Jac.'*F2