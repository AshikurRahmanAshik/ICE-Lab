clear;
bits = [0,1,1,0,1,0,1,0,1,1,1,1];

amp=1;
prev_vol=1;
cur_amp=amp*prev_vol;
bit=length(bits);
bit_rate=2;
Time=bit/bit_rate;
sampling_frequency=100;

in=1;
for i=1:length(bits)
  if bits(i)==1
    amplitude(in)=cur_amp;
    amplitude(in+1)=-cur_amp;
    cur_amp=-cur_amp;
  else
    amplitude(in)=-cur_amp;
    amplitude(in+1)=cur_amp;
  endif
  in=in+2;
endfor
cur_amp=amp*prev_vol;
bit_rate=bit_rate*2;

time=0:1/sampling_frequency:Time;

x=1;

for i=1:length(time)
  y_value(i)=amplitude(x);
  if time(i)*bit_rate>=x
    x=x+1;
  endif
endfor

plot(time,y_value,'Linewidth', 2 );
axis([0 Time -3 3]);
grid on;

disp(bits);

%demodulation

in=1;
st=1;
i=1;
for j=1:length(time)
  if time(j)*bit_rate>=i
    if mod(in,2)==1
      if y_value(j)==cur_amp;
        ans_bits(st)=1;
        cur_amp=-cur_amp;
      else
        ans_bits(st)=0;
      endif
      st=st+1;
     endif
     i=i+1;
     in=in+1;
  endif
endfor

disp('Demodulation:');
disp(ans_bits);