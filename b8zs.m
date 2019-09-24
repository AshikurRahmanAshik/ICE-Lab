clear;

bits = [0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0];

bit_rate=1;
voltage=5;
tmp = voltage;
sign = -1;
mrk = 1;
voltage = sign*voltage;
cn0=0;
cn1=0;
in = 0;

for i = 1:length(bits)
    
    if bits(i) == 0
        cn0 = cn0+1;
    else
        cn1=cn1+1;
        cn0=0;
    end
    
    if cn0>7
        y_level(i-4) = voltage;
        y_level(i-3) = -voltage;
        y_level(i-1) = -voltage;
        y_level(i) = voltage;
        cn0=0;
        c1=0;
    elseif bits(i)==0
        y_level(i) = 0;
    else 
        y_level(i) = -voltage;
        voltage=y_level(i);
    end
end

voltage=tmp;
Time=length(bits)/bit_rate; 
frequency = 1000;
time = 0:.01:Time;
x = 1;

for i = 1:length(time)
    y_value(i)= y_level(x);
    if time(i)*bit_rate>=x
        x= x+1;
    end
end
     
plot(time,y_value);
axis([0 Time -voltage-2 voltage+2]);


% demodulation



% demodulation

i=1;
in=1;
tmp=sign;
mr = 1;
in1 = -1;

for j=1:length(time)
  dm(i) = y_value(j)/voltage;
  if time(j)*bit_rate>=i 
      if dm(i)==0
        ans_bits(in)=0;
      else
        if in~=in1+1
            ans_bits(in)=1;
        end
        if tmp== dm(i)&&i>8;
            in1 = in;
            ans_bits(in) = 0;
            ans_bits(in+1) = 0;
        end
      end 
      
      if dm(i)~=0
        tmp = dm(i);
      end
      i=i+1;
      in= in+1;
  end
end
 

disp('Demodulation : ')
disp(ans_bits)