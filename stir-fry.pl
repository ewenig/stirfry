#!/usr/bin/perl

use warnings;
use strict;
use lib '/users/u18/eli/';
use XML::DOM::Lite qw(Parser);
use CGI qw(:standard);

sub get_stir_fry {
	my @weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
	my @stirfry;
	my ($node,$text,$id,$j);
	my $dom = Parser->parseFile("/users/u18/eli/stirfry/gracies-weekly.cfm", whitespace => 'strip');
	for (my $i=0;$i<7;$i++) {
		for (my $k=0;$k<3;$k++) {
			$j=0;
			$id = 'meal_' . $weekdays[$i] . '_' . ($k+1);
			$node = $dom->getElementById($id);
			if ($node eq "") { $stirfry[$i][$k] = "No data"; $j=1;}
			if ($j==0) {
				$text = $node->xml;
				if ($text =~ m/Stir( |-)Fry/i) {
					$stirfry[$i][$k] = "Yes";
				} else {
					$stirfry[$i][$k] = "No";
				}
			}
		}
	}

	return @stirfry;
}

my @weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
my @stir_fry = get_stir_fry(@weekdays);

my $breakfast = 0;
for (my $i=0;$i<7;$i++) {
	if ($stir_fry[$i][0] eq "Yes") {
		$breakfast = 1;
	}
}

print start_html( -title => "Stir Weekdays",
                  -script => { -type => "JavaScript",
				               -src  => "stirfry.js" }
				);
print "<h1 align='center'>Is there stir fry* today?</h1>\n";
print "<table border='1' align='center'><tr style='background-color:lightgrey;'><strong><td>Weekday</td>";
if ($breakfast) {
	print "<td>Breakfast</td>";
}
print "<td>Lunch</td><td>Dinner</td></strong></tr>";

for (my $i=0;$i<7;$i++) {
	print "<tr id='" . ($i+1) . "'><td><strong>$weekdays[$i]</strong></td>\n";
	for (my $k=0;$k<3;$k++) {
		if ($k != 0 || $breakfast) {
		   print "<td id='" . ($i+1) . ".$k'>" . $stir_fry[$i][$k] . "</td>\n";
		 }
	}
	print "</tr>\n";
}

print "</table>\n
<div style='position:absolute;bottom:0;font-size:75%;'>*Asian stir fry only. Thai stir fry is gross.</div>\n
<div style='position:absolute;bottom:0;right:5px;font-size:75%;'><a href='https://github.com/ewenig/stirfry'>We're on Github now apparently</a></div>\n
<br/>";
print end_html;
