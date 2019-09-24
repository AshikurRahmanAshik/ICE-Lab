clear

bits = [0,1,1,0,1,0,1,0,1,1,1,0];


amp=2;
tmp=amp;
bit =length(bits);
bit_rate = 2;
Time=bit/bit_rate;
sampling_frequency = 100;

for i=1:length(bits)
  if bits(i)==0
    amplitude(i)=amp;
  else
    amplitude(i)=-amp;
  end
endfor
time = 0:1/sampling_frequency:Time;
x=1;
for i=1:length(time)
  y_value(i)= amplitude(x);
  if time(i)*bit_rate>=x
    x=x+1;
  end
  
endfor

plot(time,y_value,'Linewidth', 2);
axis([0 Time -3 3]);
grid on;


%decoding

x = 1;

for i = 1:length(time)
    if time(i)*bit_rate>=x
        if y_value(i)<0
          ans_bits(x) = 1;
         else
          ans_bits(x) = 0;
        end
        x = x + 1;
    end
end
disp(bits);
disp('Demodulation : ');
disp(ans_bits);