%choose image to pick points from, and please save points using CTRL-E, as matlab suggests

%cpselect('BmwLeft.jpg','BmwRight.jpg')
cpselect('wdc1.jpg','wdc2.jpg')
prompt = 'press enter once finished ';
prompt = input(prompt);

%first we transpose them
mp=movingPoints';
fp=fixedPoints';
%next we need to invert the y and x because thats how we use them (due to profesor given reqs)

mpf=[mp(2,:);mp(1,:)];
fpf=[fp(2,:);fp(1,:)];

%now save using proper file name if neccessary

%bmw1=mpf;
%bmw2=fpf;
%save('bmw1');
%save('bmw2');

points1=mpf;
points2=fpf;
%save('points1');
%save('points2');