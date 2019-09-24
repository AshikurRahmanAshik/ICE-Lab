clear;
bits = [0,1,1,0,1,0,1,0,1,1,1,1];

prev_vol=1;
amp=1;
cur_amp=amp*prev_vol;
bit=length(bits);
bit_rate=2;
Time=bit/bit_rate;
sampling_frequency=100;

in=1;
for i=1:length(bits);
  if bits(i)==0
    amplitude(i)=0;
  else
    amplitude(i)=-cur_amp;
    cur_amp=amplitude(i);
  endif
endfor
cur_amp=amp*prev_vol;

time=0:1/sampling_frequency:Time;
x=1;
for i=1:length(time)
  y_value(i)=amplitude(x);
  if time(i)*bit_rate>=x
    x=x+1;
  endif
endfor

plot(time,y_value );
axis([0 Time -3 3]);
grid on;

disp(bits);

%demodulation

x=1;

for i=1:length(time)
  if time(i)*bit_rate>=x
    if y_value(i)==0
      ans_bits(x)=0;
    else
      ans_bits(x)=1;
    endif
    x=x+1;
  endif
endfor

disp('Demodulation');
disp(ans_bits);