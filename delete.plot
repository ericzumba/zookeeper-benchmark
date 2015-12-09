set xlabel "Time since start"
set ylabel "DELETE ops per second"
plot "DELETE.dat" with lines

set size 1.0, 0.6
set terminal postscript portrait enhanced color dashed lw 1 "Helvetica" 14
set output "delete.ps"
replot
set term pop