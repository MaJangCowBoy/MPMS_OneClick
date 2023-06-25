%% You should specify following variables.
 % fnam: *.dat file to plot (ex: 23MA09WH01_10K_22OCPJ05_B3_MH.dc.dat)
 % Rmgn: relibility margin (recommend x > 0.90)
 % MTMH: specify (1)MH / (2)MT.
 % mass: sample mass should be specified. (unit: gram)
 % blin: # of lines to dismiss from start of the file. (usually 31)
 
Fnam = "23JU02WH01_MT_0.3T_22OCPJ02_B2_c_MT.dc.dat";
% Fnam = "23MA08WH01_MT_0.3T_22OCPJ02_B3_c_MT.dc.dat";
Rmgn = 0.95;
MTMH = 1; 
  % 1 = MT / 2 = MH
mass = 0.0297;
Blin = 31;

%% Basically, you don't have to modify below here.
 % But anything could happen.
data = csvread(Fnam,Blin,0);
Hext = data(:,3);  Temp = data(:,4);
Magn = data(:,5);  Reli = data(:,8);
Len = length(Hext);
HTMR = zeros(Len,4); count = 1;
for it = 1:Len
  if(Reli(it) > Rmgn)
    HTMR(count,:) = [Hext(it), Temp(it), Magn(it), Reli(it)];
    count = count + 1;
  end
end

HTMR = HTMR(1:(count-1),:);

if round(MTMH) == 1
  figure('Position', [200 200 800 600]);
  MoverHm = (HTMR(:,3) ./ HTMR(:,1) ) / mass;
  Tempplt = HTMR(:,2);
  plot(Tempplt,MoverHm,'k-','linewidth',3); hold on;
  scatter(Tempplt,MoverHm,'ro','filled');
  title("M-T curve",'fontsize',20,'FontName','comic sans ms');
  xlabel("Temperature [Kelvin]",'fontsize',12,'FontName','comic sans ms');
  ylabel("M/(H*m) [emu/Oe/gram]",'fontsize',12,'FontName','comic sans ms');
  hAx=gca;
  hAx.FontName='comic sans ms';
  hAx.FontSize=13;
  grid on;
elseif round(MTMH) == 2
  figure('Position', [200 200 800 600]);
  Moverm = (HTMR(:,3)) / mass;
  Hextplt = HTMR(:,1);
  plot(Hextplt,Moverm,'k-','linewidth',3); hold on;
  scatter(Hextplt,Moverm,'ro','filled');
  title("M-H curve",'fontsize',20,'FontName','comic sans ms');
  xlabel("H_{ext} [Oe]",'fontsize',12,'FontName','comic sans ms');
  ylabel("M/m [emu/gram]",'fontsize',12,'FontName','comic sans ms');
  hAx=gca;
  hAx.FontName='comic sans ms';
  hAx.FontSize=13;
  grid on;  
end