clear;

bits = [0,1,1,0,1,0,1,0,1,1,1,0];
prev_vol=1;
amp=2;
amp=amp*prev_vol;
tmp=amp;

bit=length(bits);
bit_rate=2;
Time=bit/bit_rate;
sampling_frequency=100;

for i=1:length(bits)
  if bits(i)==0
    amplitue(i)= amp;
    amp=amplitue(i);
   else
    amplitue(i)=-amp;
    amp=amplitue(i);
  endif
endfor
amp=tmp;

time=0:1/sampling_frequency:Time;
x=1;
for i=1:length(time)
  y(i)=0;
  y_value(i)=amplitue(x);
  if time(i)*bit_rate>=x
    x=x+1;
  endif
endfor

plot(time,y_value,'Linewidth', 2 ,time,y,':');
axis([0 Time -3 3]);
grid on;

%demodulation
j=1;
in=1;
prev_amp=prev_vol;
for i=1:length(time)
  dm(j)=y_value(i)/tmp;
  if time(i)*bit_rate>=j
    if dm(j)==prev_amp
      ans_bits(in)=0;
    else
      ans_bits(in)=1;
    end;
    prev_amp=dm(j);
    in=in+1; 
    j=j+1;
  endif
endfor

disp(bits);
disp('Demodulation:');
disp(ans_bits);