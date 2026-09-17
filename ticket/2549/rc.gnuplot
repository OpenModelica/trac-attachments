set term pdf
set datafile separator ","
set xlabel "time [s]"
set ylabel "Voltage [V]"
set output "RC-res.pdf"
set style line 1 linecolor rgb "red"   lt 1 lw 2 pi 20 ps 1
set style line 2 linecolor rgb "green" lt 2 lw 2 pi 20 ps 1
set style line 3 linecolor rgb "blue"  lt 4 lw 2 pi 20 ps 1
plot "RC_res.csv" using 1:"c.v"  title "c.v"  with linespoints ls 1, \
     "RC_res.csv" using 1:"pv.v" title "pv.v" with linespoints ls 2, \
     "RC_res.csv" using 1:"r.v"  title "r.v"  with linespoints ls 3
