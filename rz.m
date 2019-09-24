clear;
bits = [0,1,1,0,1,0,1,0,1,1,1,1];


amp=1;
tmp=amp;
bit =length(bits);
bit_rate = 2;
Time=bit/bit_rate;
sampling_frequency=100;
in=1;

for i=1:length(bits)
  if bits(i)==0
    amplitude(in)= amp;
    amplitude(in+1)=0;
  else
    amplitude(in)=-amp;
    amplitude(in+1)=0;
  endif
  in=in+2;
endfor
bit_rate=bit_rate*2;
time=0:1/sampling_frequency:Time;
x=1;
for i=1:length(time)
  y_value(i)=amplitude(x);
  if time(i)*bit_rate>=x
    x=x+1;
  endif
endfor

plot(time,y_value,'Linewidth', 2);
axis([0 Time -3 3]);
grid on;

%demodulation

i=1;
in=1;
st=1;
for j=1:length(time)
  if time(j)*bit_rate>=i
    if mod(in,2)==1
      if y_value(j)==amp
        ans_bits(st)=0;
      else
        ans_bits(st)=1;
      endif
      st=st+1;
    endif
    i=i+1;
    in=in+1;
  endif
endfor

disp(bits);
disp('Demodulation:');
disp(ans_bits);