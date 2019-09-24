clear;

bits = [0,1,1,0,1,0,1,0,1,1,1,0];
amp=2;
tmp=amp;
bit=length(bits);
bit_rate=2;
Time=bit/bit_rate;
sampling_frequency=100;

for i=1:length(bits)
  if bits(i)==1
    amplitue(i)= amp;
   else
    amplitue(i)=0;
  endif
endfor

time=0:1/sampling_frequency:Time;
x=1;
for i=1:length(time)
  y_value(i)=amplitue(x);
  if time(i)*bit_rate>=x
    x=x+1;
  endif
endfor

plot(time,y_value,'Linewidth', 2);
axis([0 Time -3 3]);
grid on;

%demodulation
x=1;
for i=1:length(time)
  if time(i)*bit_rate>=x
    ans_bits(x)=y_value(i)/amp;
    x=x+1;
  endif
endfor

disp(bits);
disp('Demodulation:');
disp(ans_bits);