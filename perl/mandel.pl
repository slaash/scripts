#!/usr/bin/perl

$Y = -1.2;
for (0..24) {
	$X = -2;
	for (0 .. 79) {
		($r, $i) = (0, 0);
		for (0 .. 15) {
			$n = $_;
			$r = ($x = $r) * $x - ($y = $i) * $y + $X;
			$i = 2 * $x * $y + $Y;
			$x * $x + $y * $y > 4 && last
		}
		print unpack("\@$n a", ".,:;=+itIYVXRBM ");
		$X += 3 / 80
	}
	$Y += 2.4 / 25
}
