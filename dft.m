clear;
%continuos time sognal to discrete time signal
% x(t)=sin(2*pi*1000*t)+0.5sin(2*pi*2000*t+3*pi/4)
A=0 ;%amplitude
fs=8000 %sampling frequency
F= 0; %continuos frequency
f= F/fs; %discrete frequency
ts=1/fs  
N=8 %N point DFT
n=0:N-1;
x=sin(2*pi*1000/fs*n)+0.5*sin(2*pi*2000/fs*n+3*pi/4);
subplot(3,1,1);
stem(n,x);
grid on;
a=zeros(1,N);
b=zeros(1,N);
X=zeros(1,N);
X_angle=zeros(1,N);
for m=0:N-1
  for i=0:N-1
    a(m+1)=a(m+1)+x(i+1)*cos(2*pi*i*m/N); %real part
    b(m+1)=b(m+1)-x(i+1)*sin(2*pi*i*m/N); %imaginary part
  endfor
  X(m+1)=sqrt(a(m+1)^2 + b(m+1)^2);
  X_angle(m+1)=atan(b(m+1)/a(m+1));
endfor
m=0:N-1;
subplot(3,1,2);
stem(m,X);
grid on;
f=zeros(1,N/2);
amp=zeros(1,N/2);
k=1;
for j=1:N/2
  if X(j)>=1
    disp(X(j));
    f(k)=j*fs/N;
    amp(k)=2*X(j)/N;
    k++;
  endif
endfor
disp('frequency');
disp(f);
disp(amp);
t1=0:1/50000:0.01;
y=amp(1)*sin(2*pi*1000*t1+X_angle(1));
t2=0:1/50000:0.01;
z=amp(2)*sin(2*pi*2000*t2+X_angle(2));

subplot(3,1,3);
plot(t1,y,'r',t2,z,'g');
grid on;

%scatter(x,y3) 