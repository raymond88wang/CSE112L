set PathSeparator .

set WLFFilename waveform.wlf
log -r tb_top.*


#log -r /* 
run -all
quit
