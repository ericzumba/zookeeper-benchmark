set xlabel "Time since start"
set ylabel "CREATE ops per second"
plot "CREATE.dat" with lines

set size 1.0, 0.6
set terminal postscript portrait enhanced color dashed lw 1 "Helvetica" 14 
set output "create.ps"
replot
set term pop